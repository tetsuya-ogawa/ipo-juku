<template>
    <div class="c-companyIpoCalender_header">
        <div class="c-companyIpoCalender_header-prev" @click="changeMonth('prev')">＜</div>
        <div class="c-companyIpoCalender_header-date">{{year}}年{{month}}月</div>
        <div class="c-companyIpoCalender_header-next" @click="changeMonth('next')">＞</div>
    </div>
</template>

<script>
    export default {
        name: 'company-ipo-calender-header',
        props: ['year', 'month', 'changeMonth'],
        methods: {
            testt () {
                console.log('testtt')
            }
        },
        mounted () {
        }
    }
</script>
