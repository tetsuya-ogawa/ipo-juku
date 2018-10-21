import Blace from './blace/index.vue'

const components = [
    Blace
]

const install = function(components) {
    let hash = {}
    components.forEach((item) => {
        hash[item.name] = item
    })
    return hash
}

export default install(components)