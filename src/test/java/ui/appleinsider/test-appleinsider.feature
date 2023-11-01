Feature: browser automation 2

  Background:
  * configure driver = { type: 'chrome', highlight: true, addOptions: ['--remote-allow-origins=*', '--start-maximized'] }

  Scenario: iPhone 13 vs iPhone 12
    Given driver 'https://appleinsider.ru'
    And waitFor("//input[@type='text']").input('Чем iPhone 13 отличается от iPhone 12' +  Key.ENTER)
    And waitFor('//h2//a')
    * def href = driver.script("document.querySelector('h2 > a').getAttribute('href')")
    * match href contains 'iphone-13'

    Given url 'https://reqres.in/api/users?page=2'
    When method get
    Then status 200
    And match each $response.data[*].email contains 'reqres.in'