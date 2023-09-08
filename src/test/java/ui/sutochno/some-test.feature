Feature: browser automation 3

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

  Scenario: Open ozon.ru and match url
    Given driver 'https://ozon.ru/'
    * def urlValue = driver.url
    * driver.maximize()
    And match urlValue == 'https://www.ozon.ru/'

  Scenario: iioo ozon.ru
    Given driver 'https://ozon.ru/'
    * driver.maximize()
    * driver.url = 'https://www.ozon.ru/category/elektronika-15500/'
    * delay(10000)
#    And match urlValue == 'https://www.ozon.ru/'

  Scenario: oodfjkksssa dfdf ozon.ru
    Given driver 'https://appleinsider.ru/'
    * driver.maximize()
    # В случае поиска xpath, выглядело бы так: //li[@id='menu-item-494525']//a
    * waitFor("{a}iPhone 15")
    * click("{a}iPhone 15")
    * click("{a}iPhone 14")
    * delay(8000)


  Scenario: Перейти с iPhone 15 на iPhone 14 на appleinsider.ru
    Given driver 'https://appleinsider.ru/'
    * driver.maximize()
    * waitFor("{a}iPhone 15")
    * rightOf("{a}iPhone 15").find('{a}iPhone 14').click()
    * delay(6000)

  Scenario: Получить title
    Given driver 'https://appleinsider.ru/'
    * print 'title--', driver.title
    * match driver.title == 'AppleInsider.ru — крупнейший сайт о iPhone, iPad, Mac в России'

  Scenario: Нажать на элемент и вернуться
    Given driver 'https://appleinsider.ru/'
    Then maximize()
    * click('{a}Apple Watch')
    * delay(1000).screenshot("//*[@id='menu-item-482300']")
    * driver.back()
    * delay(1000)
    * driver.forward()
    * delay(1000)
    * driver.refresh()
    * driver.reload()