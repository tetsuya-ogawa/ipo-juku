<template>
    <div @click="onClick()">
        <ImageUploadModal :blace=blace />
    </div>
</template>

<script>
    import Vue from 'vue';
    import ImageUploadModal from './image_upload_modal.vue';

    export default {
        name: 'editor_header',
        props: ['blace'],
        components: {
            ImageUploadModal,
        },
        methods: {
            onClick() {
                console.log(this.blace)
            },
        },
        mounted() {
        }
    }
</script>