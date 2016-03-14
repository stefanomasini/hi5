import wiringpi
from utils import debounce


BCM_BUTTONS = (
    (1, 18),
    (2, 23),
    (3, 24),
)

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


    for btnNum, bcmPin in BCM_BUTTONS:
        @debounce(0.02)
        def reportClick():
            if wiringpi.digitalRead(bcmPin) == 0:
                postButtonClickEvent(btnNum)

        wiringpi.pinMode(bcmPin, wiringpi.GPIO.INPUT)
        wiringpi.pullUpDnControl(bcmPin, wiringpi.GPIO.PUD_UP)
        wiringpi.wiringPiISR(bcmPin, wiringpi.GPIO.INT_EDGE_BOTH, reportClick)
