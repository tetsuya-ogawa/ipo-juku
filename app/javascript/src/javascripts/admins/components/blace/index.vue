<template>
    <div>
        <AceEditor
            :fontSize="14"
            :showPrintMargin="true"
            :showGutter="true"
            :highlightActiveLine="true"
            mode="html"
            theme="monokai"
            :onChange="onChange"
            name="editor"
            :editorProps="{$blockScrolling: true, name: 'article[body]'}"
            :width="'100%'"
            :value="body"
        />
        <input type="hidden" :name="form_name" :value="content">
    </div>
</template>

<script>
    import Vue from 'vue';
    import brace from 'brace';
    import { Ace as AceEditor, Split as SplitEditor } from 'vue2-brace-editor';
    import 'brace/mode/html';
    import 'brace/theme/monokai';

    export default {
        name: 'editor',
        data() {
            return {
              content: '',
            }
        },
        props: ['body', 'form_name'],
        components: {
            AceEditor,
            SplitEditor,
        },
        methods: {
            onChange(newValue) {
              this.content = newValue
            }
        },
        mounted() {
            console.log(this.body)
            this.content = this.body
        }
    }
</script>