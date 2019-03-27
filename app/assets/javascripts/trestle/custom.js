// This file may be used for providing additional customizations to the Trestle
// admin. It will be automatically included within all admin pages.
//
// For organizational purposes, you may wish to define your customizations
// within individual partials and `require` them here.
//
//  e.g. //= require "trestle/custom/my_custom_js"

$(function(){
  $(document).on('click', '#add_alias', function(e) {
    e.preventDefault();
    el = e.target;
    wrapper = document.querySelector('.person_aliases');
    input = wrapper.querySelector('.input-group');
    newInput = input.cloneNode(true);
    newInput.querySelector('input').value = '';
    wrapper.insertBefore(newInput, el);
  })
})
