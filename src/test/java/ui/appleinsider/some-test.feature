Feature: Another Test

  Background:
    * configure driver = { type: 'chrome', addOptions: ["--remote-allow-origins=*"] }
    * configure afterScenario =
    """
      function(){
        var info = karate.info;
        karate.log(info);
        if(info.errorMessage){
          driver.screenshot();
        }
      }
    """

    * configure afterScenario =
    """
      function(){
        var info = karate.info;
        karate.log(info);
        if(info.errorMessage){
          driver.screenshot();
          karate.call('rerun.feature');
        }
      }
    """

  Scenario: shadowRoot
    Given driver 'chrome://downloads/'
    * delay(3000)
    * def heading = script("document.querySelector('body > downloads-manager').shadowRoot.querySelector('#toolbar').shadowRoot.querySelector('#toolbar').shadowRoot.querySelector('#leftSpacer > h1').textContent")
    * print 'heading----', heading

  Scenario: Перевести в pdf страницу сайта
    * configure driver = { type: 'msedge', addOptions: ["--remote-allow-origins=*"] }
    Given driver 'https://lipsum.com//'
    * def pdfDoc = pdf({'orientation': 'landscape'})
    * karate.write(pdfDoc, "pdfDoc.pdf")

  Scenario: Получить title
    Given driver 'https://appleinsider.ru/'
    * print 'title--', driver.title
    * match driver.title == 'AppleInsider.ru — крупнейший сайт о iPhone, iPad, Mac в России'

  Scenario: innerHTML
    Given driver 'https://appleinsider.ru/'
    * delay(3000)
    * match driver.title == 'AppleInsider.ru — крупнейший сайт о iPhone, iPad, Mac в России'
    And match script('.sitename-text', '_.innerHTML') == 'AppleInsider.ru'