import CompanyIpoCalender from '../../common/components/company_ipo_calender/company_ipo_calender.vue'

const components = [
    CompanyIpoCalender
]

const install = function(components) {
    let hash = {}
    components.forEach((item) => {
        hash[item.name] = item
    })
    return hash
}

export default install(components)