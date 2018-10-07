<template>
    <div class="c-companyIpoCalender">
        <company-ipo-calender-header :year=year :month=month :change-month="changeMonth" />
        <company-ipo-calender-body :year=year :month=month :ipo-information=ipoInformation />
    </div>
</template>

<script>
    import moment from 'moment'
    import CompanyIpoCalenderHeader from './company_ipo_calender_header.vue'
    import CompanyIpoCalenderBody from './company_ipo_calender_body.vue'
    export default {
        name: 'company-ipo-calender',
        components: {
            CompanyIpoCalenderHeader,
            CompanyIpoCalenderBody
        },
        props: ['ipoInformation'],
        data() {
            return {
                year: null,
                month: null,
            }
        },
        mounted() {
            this.year = new Date(JSON.parse(this.ipoInformation)['lottery_period_start']).getFullYear()
            this.month = new Date(JSON.parse(this.ipoInformation)['lottery_period_start']).getMonth() + 1
        },
        created () {
            const received = this.$store.getters['companies']
        },
        computed: {
        },
        methods: {
            changeMonth(type) {
                let year = this.year
                let month = this.month
                if(type == 'next'){
                    if(month == 12){
                        month = 1
                        year += 1
                    } else {
                        month += 1
                    }
                } else if(type == 'prev'){
                    if(month == 1){
                        month = 12
                        year -= 1
                    } else {
                        month -= 1
                    }
                }
                this.year = year
                this.month = month
            }
        },
    }
</script>