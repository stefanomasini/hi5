import wiringpi
from utils import debounce

BCM_BTN_1 = 18
BCM_BTN_2 = 23
BCM_BTN_3 = 24

BCM_PIR = 20


def configureHardware(postMotionEvent, postButtonClickEvent):
    wiringpi.wiringPiSetupGpio()

    def reportMotion():
        if wiringpi.digitalRead(BCM_PIR) == 1:
            postMotionEvent()

    def gpio_callback():
        reportClick()

    wiringpi.pinMode(BCM_PIR, wiringpi.GPIO.INPUT)
    wiringpi.pullUpDnControl(BCM_PIR, wiringpi.GPIO.PUD_OFF)
    wiringpi.wiringPiISR(BCM_PIR, wiringpi.GPIO.INT_EDGE_BOTH, reportMotion)


    for btnNum, bcmPin in (
                (1, BCM_BTN_1),
                (2, BCM_BTN_2),
                (3, BCM_BTN_3),
            ):
        @debounce(0.02)
        def reportClick(_bcmPin=bcmPin, _btnNum=btnNum):
            if wiringpi.digitalRead(_bcmPin) == 0:
                postButtonClickEvent(_btnNum)

        wiringpi.pinMode(bcmPin, wiringpi.GPIO.INPUT)
        wiringpi.pullUpDnControl(bcmPin, wiringpi.GPIO.PUD_UP)
        wiringpi.wiringPiISR(bcmPin, wiringpi.GPIO.INT_EDGE_BOTH, reportClick)
