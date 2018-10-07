<template>
    <div class="c-companyIpoCalender_body">
        <table class="c-companyIpoCalender_body-table">
            <thead>
                <tr>
                    <th>日</th>
                    <th>月</th>
                    <th>火</th>
                    <th>水</th>
                    <th>木</th>
                    <th>金</th>
                    <th>土</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="dateRow in dateRows">
                    <td v-for="date in dateRow" class="c-companyIpoCalender_date" v-bind:class="[date.kind, date.bbPeriod, date.pPeriod, date.listingDate, date.winningDate, date.today]">
                        <span>{{date['date']}}</span>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="c-companyIpoCalender_body-week"></div>
    </div>
</template>

<script>
    const weekOfDay = [ "日", "月", "火", "水", "木", "金", "土" ]
    export default {
        name: 'company-ipo-calender-body',
        props: ['year', 'month', 'ipoInformation'],
        methods: {
          bookBuildingClass(year, month, date) {
              const bb_start = new Date(this.parsedIpoInformation['lottery_period_start'] + 'T00:00+09:00')
              const bb_end = new Date(this.parsedIpoInformation['lottery_period_end'] + 'T00:00+09:00')
              const target = new Date(year, month - 1, date)
              const option = bb_start.getTime() == target.getTime() ? '--start' : target.getTime() == bb_end.getTime() ? '--end' : ''
              return bb_start <= target && target <= bb_end ? `bbPeriod${option}` : ''
          },
          purchaseClass(year, month, date) {
              const p_start = new Date(this.parsedIpoInformation['purchase_period_start'] + 'T00:00+09:00')
              const p_end = new Date(this.parsedIpoInformation['purchase_period_end'] + 'T00:00+09:00')
              const target = new Date(year, month - 1, date)
              const option = p_start.getTime() == target.getTime() ? '--start' : target.getTime() == p_end.getTime() ? '--end' : ''
              return p_start <= target && target <= p_end ? `pPeriod${option}` : ''
          },
          isListingDate(year, month, date) {
              const listingDate = new Date(this.parsedIpoInformation['listing_date'] + 'T00:00+09:00')
              return listingDate.getTime() == new Date(year, month - 1, date).getTime()
          },
          isWinningDate(year, month, date) {
              const winningDate = new Date(this.parsedIpoInformation['winning_date'] + 'T00:00+09:00')
              return winningDate.getTime() == new Date(year, month - 1, date).getTime()
          },
          isToday(year, month, date) {
              return new Date().setHours(0, 0, 0, 0) == new Date(year, month - 1, date).getTime()
          }
        },
        computed: {
          dateRows() {
            let rows = []
            let firstDateWeekDay =  new Date(this.year, this.month - 1, 1).getDay()
            let lastDate = new Date(this.year, this.month, 0).getDate()
            let prevMonthLastDate = new Date(this.year, this.month - 1, 0).getDate()
            let calenderDate = [...Array(42).keys()].map(i => {
                const bookBuildingPeriod = this.bookBuildingClass(this.year, this.month, i - firstDateWeekDay + 1)
                const purchasePeriod = this.purchaseClass(this.year, this.month, i - firstDateWeekDay + 1)
                const listingDate = this.isListingDate(this.year, this.month, i - firstDateWeekDay + 1) ? 'isListingDate' : ''
                const winningDate = this.isWinningDate(this.year, this.month, i - firstDateWeekDay + 1) ? 'isWinningDate' : ''
                const isToday = this.isToday(this.year, this.month, i - firstDateWeekDay + 1) ? 'today' : ''
                if(i < firstDateWeekDay) {
                    return { date: prevMonthLastDate + ++i - firstDateWeekDay, kind: 'prev', bbPeriod: bookBuildingPeriod, pPeriod: purchasePeriod, listingDate: listingDate, winningDate: winningDate, today: isToday }
                } else if (i == firstDateWeekDay){
                    return { date: ++i - firstDateWeekDay, bbPeriod: bookBuildingPeriod, pPeriod: purchasePeriod, listingDate: listingDate, winningDate: winningDate, today: isToday }
                } else if(firstDateWeekDay < i && i < lastDate + firstDateWeekDay) {
                    return { date: ++i - firstDateWeekDay, bbPeriod: bookBuildingPeriod, pPeriod: purchasePeriod, listingDate: listingDate, winningDate: winningDate, today: isToday }
                } else {
                    return { date: ++i - lastDate - firstDateWeekDay, kind: 'next', bbPeriod: bookBuildingPeriod, pPeriod: purchasePeriod, listingDate: listingDate, winningDate: winningDate, today: isToday }
                }
            })
            for(let i = 0; i < Math.ceil(calenderDate.length / 7); i++) {
                const j = i * 7;
                const p = calenderDate.slice(j, j + 7); // i*cnt 番目から i*cnt+cnt 番目まで取得
                rows.push(p);                    // 取得したものを newArr に追加
            }
            return rows
          },
          parsedIpoInformation() {
            return JSON.parse(this.ipoInformation)
          }
        },
        created () {
            const received = this.$store.getters['companies']
        }
    }
</script>
