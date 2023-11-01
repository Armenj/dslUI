Feature: Test Calopso

  Background:
    * configure driver = { type: 'chrome', highlight: true, addOptions: ['--remote-allow-origins=*', '--start-maximized'] }
    * call read('login.feature@authorization-cookie')

  Scenario: Вывод суммы всех товаров
    * click('{div}Аксессуары для Calypso')
    * scroll("//div[contains(@class,'top_wrapper')]")

    * def total = 0
    * def texts = scriptAll("//div[contains(@class,'top_wrapper')]//span[@class='price_value']", '_.textContent')
    * match each texts == '#string'

    * def fun = function(texts){ var num = parseInt(texts.replace(/\s/g, ''), 10); total += num; }
    * karate.forEach(texts, fun)
    * print 'Total price is: ', total
    * print texts
    * def allCookies = driver.cookies
    * print 'All cookies:', allCookies
    * clearCookies()
    * match driver.cookies == '#[0]'