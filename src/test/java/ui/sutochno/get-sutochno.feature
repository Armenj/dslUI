Feature: browser automation 2

  Background:
  * configure driver = { type: 'chrome', addOptions: ["--remote-allow-origins=*"] }

  Scenario: Open AppleInsider.ru and search for iPhone 15
    Given driver 'https://appleinsider.ru'
    * driver.maximize()
    And waitFor("//input[@type='text']")
    And input("//input[@type='text']", 'Айфон 15')
    And input("//input[@type='text']", '\n')
    #В коллекцию elements помещаются все элементы
    And waitFor('//h2//a')
    * def elements = driver.locateAll('//h2//a')

    * def elementExists = driver.locateAll('//h2//a').length > 0
    * assert elementExists == true

    * def firstElement = elements[0]
    * def href = driver.script("document.querySelector('h2 > a').getAttribute('href')")

    * match href contains 'iphone-15'