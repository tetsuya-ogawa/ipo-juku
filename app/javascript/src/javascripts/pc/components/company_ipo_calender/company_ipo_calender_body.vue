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
                    <td v-for="date in dateRow" class="c-companyIpoCalender_date" v-bind:class="{ notCurrentMonth: !date.isCurrent }">{{date['date']}}</td>
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
        props: ['year', 'month'],
        methods: {
        },
        computed: {
          dateRows() {
            let rows = []
            let firstDateWeekDay =  new Date(this.year, this.month - 1, 1).getDay()
            let lastDate = new Date(this.year, this.month, 0).getDate()
            let prevMonthLastDate = new Date(this.year, this.month - 1, 0).getDate()
            let calenderDate = [...Array(42).keys()].map(i => {
                if(i < firstDateWeekDay) {
                    return { isCurrent: false, date: prevMonthLastDate + ++i - firstDateWeekDay }
                } else if (i == firstDateWeekDay){
                    return { isCurrent: true, date: ++i - firstDateWeekDay }
                } else if(firstDateWeekDay < i && i < lastDate + firstDateWeekDay) {
                    return { isCurrent: true, date: ++i - firstDateWeekDay }
                } else {
                    return { isCurrent: false, date: ++i - lastDate - firstDateWeekDay }
                }
            })
            for(let i = 0; i < Math.ceil(calenderDate.length / 7); i++) {
                const j = i * 7;
                const p = calenderDate.slice(j, j + 7); // i*cnt 番目から i*cnt+cnt 番目まで取得
                rows.push(p);                    // 取得したものを newArr に追加
            }
            return rows
          }
        },
        created () {
            const received = this.$store.getters['companies']
        }
    }
</script>
