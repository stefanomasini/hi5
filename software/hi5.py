import os
os.environ["SDL_FBDEV"] = "/dev/fb1"
#os.environ["SDL_VIDEODRIVER"] = "/dev/fb1"
import sys, pygame

BTN_1 = 18
BTN_2 = 23
BTN_3 = 24

BCM_PIR = 20

RPI_BTN_PRESSED = pygame.USEREVENT+1
RPI_MOTION = pygame.USEREVENT+2
RPI_MOTION_DONE = pygame.USEREVENT+3

# -----------

import wiringpi

from threading import Timer

def debounce(wait):
    """ Decorator that will postpone a functions
        execution until after wait seconds
        have elapsed since the last time it was invoked. """
    def decorator(fn):
        def debounced(*args, **kwargs):
            def call_it():
                fn(*args, **kwargs)
            try:
                debounced.t.cancel()
            except(AttributeError):
                pass
            debounced.t = Timer(wait, call_it)
            debounced.t.start()
        return debounced
    return decorator

#@debounce(0.02)
def reportMotion():
    value = wiringpi.digitalRead(BCM_PIR)
    if value == 1:
        pygame.event.post(pygame.event.Event(RPI_MOTION))
        pygame.time.set_timer(RPI_MOTION_DONE, 1000)
    #print value
    #if value == 0:
        #my_event = pygame.event.Event(RPI_BTN_PRESSED, btnNum=1)
        #pygame.event.post(my_event)

def gpio_callback():
    reportClick()

wiringpi.wiringPiSetupGpio()
wiringpi.pinMode(BCM_PIR, wiringpi.GPIO.INPUT)
#wiringpi.pullUpDnControl(BTN_1, wiringpi.GPIO.PUD_UP)
wiringpi.pullUpDnControl(BCM_PIR, wiringpi.GPIO.PUD_OFF)

wiringpi.wiringPiISR(BCM_PIR, wiringpi.GPIO.INT_EDGE_BOTH, reportMotion)



# -----------

pygame.init()

size = width, height = 320, 240
speed = [1, 1]
black = 0, 0, 0

screen = pygame.display.set_mode(size)

ball = pygame.image.load("ball.png")
ballrect = ball.get_rect()


from netifaces import interfaces, ifaddresses, AF_INET
textLines = []
for ifaceName in interfaces():
    addresses = [i['addr'] for i in ifaddresses(ifaceName).setdefault(AF_INET, [{'addr':'No IP addr'}] )]
    textLines.append('%s: %s' % (ifaceName, ', '.join(addresses)))


pygame.mouse.set_visible(False)

ballVisible = False

while 1:
    screen.fill(black)

    for event in pygame.event.get():
        if event.type == pygame.QUIT: sys.exit()
        if event.type == pygame.MOUSEBUTTONDOWN: sys.exit()
        if event.type == RPI_MOTION:
            ballVisible = True
        if event.type == RPI_MOTION_DONE:
            pygame.time.set_timer(RPI_MOTION_DONE, 0)
            ballVisible = False
            #print 'BUTTON PRESSED!', event.btnNum
        if event.type == RPI_BTN_PRESSED:
            print 'BUTTON PRESSED!', event.btnNum

    if ballVisible:
        screen.blit(ball, ballrect)
    #ballrect = ballrect.move(speed)
    #if ballrect.left < 0 or ballrect.right > width:
        #speed[0] = -speed[0]
    #if ballrect.top < 0 or ballrect.bottom > height:
        #speed[1] = -speed[1]

    #screen.blit(ball, ballrect)

    font = pygame.font.Font(None, 18)
    text = font.render(' - '.join(textLines), 1, (255, 255, 255))
    textpos = text.get_rect()
    textpos.centerx = screen.get_rect().centerx
    screen.blit(text, textpos)


    pygame.display.flip()
