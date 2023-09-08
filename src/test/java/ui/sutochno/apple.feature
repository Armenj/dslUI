Feature: browser automation 2

  Background:
    * configure driver = { type: 'chrome', addOptions: ["--remote-allow-origins=*"] }

  Scenario: Open AppleInsider.ru and search for iPhone 15
    Given driver 'https://appleinsider.ru'
    * driver.maximize()
    * def searchBox = "//input[@type='text']"
    * def linkSelector = "h2.entry-title a"
    And waitFor(searchBox)
    And input(searchBox, 'Айфон 15' + Key.ENTER)
    And waitFor(linkSelector)
    * screenshot()

    * def elements = driver.locateAll(linkSelector)
    * def elementExists = elements.length > 0
    * assert elementExists == true
    * def firstElement = elements[0]
    * screenshot()
    * def href = driver.script("document.querySelector('h2 > a').getAttribute('href')")
    * match href contains 'ajfon-15'

    Given url 'https://reqres.in/api/users?page=2'
    When method get
    Then status 200
    And match each $response.data[*].email contains 'reqres.in'

