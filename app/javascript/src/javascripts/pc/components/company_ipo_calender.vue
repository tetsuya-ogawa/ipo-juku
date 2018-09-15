<template>
    <div>
        <h1 @click="testt()">ok牧場{{testProps}}</h1>
    </div>
</template>

<script>
    export default {
        name: 'company-ipo-calender',
        props: ['testProps'],
        methods: {
            testt () {
                console.log('testtt')
            }
        },
        created () {
            const received = this.$store.getters['companies']
            console.log(received)
        }
    }
</script>