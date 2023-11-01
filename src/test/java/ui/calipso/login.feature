Feature: Авторизация пользователя
  Background:
    * configure driver = { type: 'chrome', addOptions: ['--remote-allow-origins=*', '--start-maximized'] }
    * call read 'locators.json'

  @authorization-cookie
  Scenario: Авторизация с помощью Cookie
    * def loginCookie = { name: 'PHPSESSID', value: 'KO2kWDB70btk1ka0lEikMxgq92aN2Oiq', domain: '.calypso-camera.ru' }
    * driver 'about:blank'
    * driver.cookie(loginCookie)
    * driver 'https://calypso-camera.ru/'
    * match cookie('PHPSESSID') contains loginCookie

  @user-authohization
  Scenario: Авторизация испольязуя json-карту для локаторов
    * driver 'https://calypso-camera.ru'
    * driver.maximize()
    * waitFor(mainPage.enter).click()
    * click(authPopUp.userLogin).input('a.melixetyan@yandex.ru')
    * click(authPopUp.userPass).input('qwerty123')
    * click(authPopUp.getInButton)
    * waitForEnabled(mainPage.authAllert)
    And match text("//div[contains(@class, 'notice__title')]") == 'Вы успешно авторизовались'
    * screenshot()

  @user-registration
  Scenario: Регистрация пользователя испольязуя json-карту для локаторов
    Given driver 'https://calypso-camera.ru'
    * waitFor(mainPage.enter).click()
    * waitFor(authPopUp.regButton).click()
    * def randomPart = java.util.UUID.randomUUID().toString().substring(0, 3)
    * def randomEmail = 'user' + randomPart + '@yandex.ru'
    * print randomEmail
    * scroll(regPage.name).input('Армен Меликс')
    * input(regPage.email, randomEmail)
    * input(regPage.phone, '9283394503')
    * input(regPage.pass, 'qwerty123')
    * input(regPage.confirm, 'qwerty123')
    * scroll(regPage.registr)
    * click(regPage.licence)
    * click(regPage.registr)
    * waitForEnabled(mainPage.registrAllert)

  Scenario: Регистрация нового пользователя
    Given driver 'https://calypso-camera.ru'
    * waitFor('{span}Войти').click()
    * waitFor('{a}Регистрация').click()
    * def randomPart = java.util.UUID.randomUUID().toString().substring(0, 3)
    * def randomEmail = 'user' + randomPart + '@yandex.ru'
    * print randomEmail
    * scroll("//input[@id='input_NAME']").input('Армен Меликс')
    * input("//input[@id='input_EMAIL']", randomEmail)
    * input("//input[@id='input_PERSONAL_PHONE']", '9283394503')
    * input("//input[@id='input_PASSWORD']", 'qwerty123')
    * input("//input[@id='input_CONFIRM_PASSWORD']", 'qwerty123')
    * scroll('{button}Зарегистрироваться')
    * click("#licenses_register")
    * click('{button}Зарегистрироваться')
    * waitForEnabled("//div[contains(@class, 'notice--link')]")

  Scenario: Авторизация
    * driver 'https://calypso-camera.ru'
    * waitFor(mainPage.enter).click()
    * click('#USER_LOGIN_POPUP').input('a.melixetyan@yandex.ru')
    * click('#USER_PASSWORD_POPUP').input('qwerty123')
    * click("//input[@name='Login']")
    * waitForEnabled("//div[@class='notice__detail']")
    * screenshot()