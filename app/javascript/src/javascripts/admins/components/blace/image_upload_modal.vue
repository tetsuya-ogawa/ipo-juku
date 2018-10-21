<template>
    <label class="c-editor_imageUploadButton">
      画像挿入
      <input @change="uploadFile" type="file" name="image">
    </label>
</template>

<script>
    import Vue from 'vue';
    import axios from 'axios'

    export default {
        name: 'image_upload_modal',
        props: ['blace'],
        methods: {
            uploadFile(e) {
                let formData = new FormData();
                formData.append('file', e.target.files[0]);
                let config = {
                    headers: {
                        'content-type': 'multipart/form-data'
                    }
                };
                axios.post('/api/v1/images', formData, config).then(res => {
                    this.blace.insert(`![alt](${res['data']['url']})`)
                }).catch(err => {
                    console.log(err)
                });
                e.target.value = ''
            },
        },
        mounted() {
        }
    }
</script>