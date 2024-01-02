// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import $ from 'jquery'
import "./controllers"
import * as bootstrap from "bootstrap"

// javascript do alerta de flash
document.addEventListener('turbo:load', function(){
  setTimeout(function(){
    $('.flash-message').remove();
  }, 5000);
});
