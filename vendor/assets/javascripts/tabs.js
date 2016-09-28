var tablinkClass    = '.tablinks',
    tabContentClass = '.tabcontent',
    $tabLink    = $(tablinkClass),
    $tabContent = $(tabContentClass);

$tabLink.click(function() {
  var tabId = $(this).attr('id');

  toogleClass($tabContent, $tabContent, tabId);
  toogleClass($tabLink, this);
});

function toogleClass(elementFirst, elementSecond, params='') {
  var foundElement;

  $(elementFirst).removeClass('active');

  if (!params) {
    return $(elementSecond).addClass('active');
  }

  foundElement = jQuery.grep(elementSecond, function(element) {
    return $(element).attr('id') === params;
  });

  $(foundElement).addClass('active')
}
