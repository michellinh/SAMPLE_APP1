require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("bootstrap")
import I18n from 'i18n-js/index.js.erb'
window.I18n = I18n
require("packs/micropost")
