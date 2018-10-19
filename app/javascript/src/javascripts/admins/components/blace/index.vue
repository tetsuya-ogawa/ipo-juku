<template>
    <div>
        <BlaceHeader :blace=editor />
        <AceEditor
            :fontSize="14"
            :showPrintMargin="true"
            :showGutter="true"
            :highlightActiveLine="true"
            mode="html"
            theme="monokai"
            :onChange="onChange"
            :onLoad="onLoad"
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
    import BlaceHeader from './blace_header.vue'

    export default {
        name: 'editor',
        data() {
            return {
              content: '',
              editor: null,
            }
        },
        props: ['body', 'form_name'],
        components: {
            AceEditor,
            SplitEditor,
            BlaceHeader,
        },
        methods: {
            onChange(newValue) {
              this.content = newValue
            },
            onLoad(editor) {
                this.editor = editor
            }
        },
        mounted() {
            this.content = this.body
        }
    }
</script>