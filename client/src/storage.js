/**
 * Author : Mathieu Dufour <https://github.com/bloodbee>
 * Updated : 23/09/2019
 * This file is a wrapped for the local storage. You can require this file anywhere and use it as db.MYMETHOD(MYARGS)
 * Doc : Read The Fucking Code
 */


const db = {

  isJson(data) {
    if (typeof data == 'object')
      return true
    return false
  },

  isString(data) {
    if (typeof data == 'string')
      return true
    return false
  },

  isBool(data) {
    if (typeof data == 'boolean')
      return true
    return false
  },

  stringify(data) {
    if (data != null)
     return JSON.stringify(data)
    return null
  },

  parse(data) {
    if (data != null)
     return JSON.parse(data)
    return null
  },

  store(key, value) {
    console.log(key, value)
    if (key != null && key != '') {
      if (this.isString(value)) {
        localStorage.setItem(key, value)
      } else if (this.isJson(value)) {
        localStorage.setItem(key, this.stringify(value))
      } else if (this.isBool(value)) {
        value ? localStorage.setItem(key, "true") : localStorage.setItem(key, "false")
      }
    }
  },

  storeAction(action, data) {
    console.log(action, data)
    if (action != null && action != '') {
      // get actions
      let actions = JSON.parse(localStorage.get('actions'))

      actions.push({
        name: action,
        data: data
      })
      
      localStorage.setItem('actions', actions)
    }
  },

  getJson(key) {
    if (key != null && key != '') {
      let item  = localStorage.getItem(key)

      return this.parse(item)
    }

    return null
  },

  getString(key) {
    if (key != null && key != '') {
      return localStorage.getItem(key)
    }

    return null
  },

  getAll() {
    let datas = {}
    for (let index = 0; index < localStorage.length; index++) {
      datas[localStorage.key([i])] = parse(localStorage.getItem(localStorage.key([i])))
    }

    return datas
  },

  exist(key) {
    if (key != null && key != '') {
      let item = this.getString(key)

      if (item != null)
        return true
    }
    return false
  },

  remove(key) {
    if (key != null && key != '') {
      localStorage.removeItem(key)
    }
  },

  removeAll(key) {
    if (key != null && key != '') {
      localStorage.clear()
    }
  },

  display() {
    for (let index = 0; index < localStorage.length; index++) {
      console.log(localStorage.getItem(localStorage.key([i])))
    }
  }

}

export default db