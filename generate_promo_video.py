"""
DueMate Smart Reminder — Play Store promo video
1280×720, 30 fps, ~40 seconds
"""
from PIL import Image, ImageDraw, ImageFont
import numpy as np
import cv2
import math

W, H   = 1280, 720
FPS    = 30
OUT    = r"D:\flutter_projects\DueMateSmartReminder\screenshots\duemate_promo.mp4"

# ── colours ────────────────────────────────────────────────────────────────
BLUE_DARK  = (13,  71,  161)
BLUE_MID   = (21,  101, 192)
BLUE_LIGHT = (30,  136, 229)
WHITE      = (255, 255, 255)
ACCENT     = (100, 181, 246)
RED        = (244,  67,  54)
GREEN      = ( 76, 175,  80)
ORANGE     = (255, 152,   0)
GREY_BG    = (236, 239, 241)
DARK_TEXT  = ( 33,  33,  33)

def lerp(a, b, t):
    return a + (b - a) * t

def ease_out(t):
    return 1 - (1 - t) ** 3

def ease_in_out(t):
    return t * t * (3 - 2 * t)

# ── fonts ───────────────────────────────────────────────────────────────────
def font(size, bold=False):
    paths = [
        r"C:\Windows\Fonts\arialbd.ttf" if bold else r"C:\Windows\Fonts\arial.ttf",
        r"C:\Windows\Fonts\calibrib.ttf" if bold else r"C:\Windows\Fonts\calibri.ttf",
        r"C:\Windows\Fonts\segoeui.ttf",
    ]
    for p in paths:
        try:
            return ImageFont.truetype(p, size)
        except Exception:
            pass
    return ImageFont.load_default()

F_TITLE   = font(96, bold=True)
F_LARGE   = font(72, bold=True)
F_MED     = font(52, bold=True)
F_SUB     = font(40)
F_BODY    = font(34)
F_SMALL   = font(28)
F_TINY    = font(22)

# ── helpers ─────────────────────────────────────────────────────────────────
def pil_to_cv(img):
    arr = np.array(img.convert("RGB"))
    return cv2.cvtColor(arr, cv2.COLOR_RGB2BGR)

def gradient_bg(draw, c1=BLUE_DARK, c2=BLUE_LIGHT):
    for x in range(W):
        t = x / W
        r = int(c1[0] + (c2[0]-c1[0])*t)
        g = int(c1[1] + (c2[1]-c1[1])*t)
        b = int(c1[2] + (c2[2]-c1[2])*t)
        draw.line([(x,0),(x,H)], fill=(r,g,b))

def text_center(draw, text, y, fnt, fill=WHITE, shadow=True):
    bbox = draw.textbbox((0,0), text, font=fnt)
    tw = bbox[2]-bbox[0]
    x = (W - tw) // 2
    if shadow:
        draw.text((x+2, y+2), text, font=fnt, fill=(0,0,0,80))
    draw.text((x, y), text, font=fnt, fill=fill)
    return x, y

def rounded_rect(draw, x0, y0, x1, y1, r, fill, outline=None, lw=0):
    draw.rectangle([x0+r, y0, x1-r, y1], fill=fill)
    draw.rectangle([x0, y0+r, x1, y1-r], fill=fill)
    for cx, cy in [(x0,y0),(x1-2*r,y0),(x0,y1-2*r),(x1-2*r,y1-2*r)]:
        draw.ellipse([cx, cy, cx+2*r, cy+2*r], fill=fill)
    if outline and lw:
        for i in range(lw):
            draw.rectangle([x0+r,y0+i,x1-r,y0+i], outline=outline)
            draw.rectangle([x0+r,y1-i,x1-r,y1-i], outline=outline)
            draw.rectangle([x0+i,y0+r,x0+i,y1-r], outline=outline)
            draw.rectangle([x1-i,y0+r,x1-i,y1-r], outline=outline)

def draw_bell(draw, cx, cy, scale=1.0, fill=WHITE, bg=BLUE_MID):
    bw = int(80*scale)
    bh = int(70*scale)
    bt = int(cy - 80*scale)
    draw.ellipse([cx-bw//2, bt, cx+bw//2, bt+bh+12], fill=fill)
    draw.rectangle([cx-bw//2, bt+bh//2, cx+bw//2, cy+20*scale], fill=fill)
    draw.ellipse([cx-bw//2-12*scale, cy+12*scale, cx+bw//2+12*scale, cy+44*scale], fill=fill)
    draw.ellipse([cx-12*scale, cy+36*scale, cx+12*scale, cy+64*scale], fill=fill)
    draw.rectangle([cx-7*scale, bt-18*scale, cx+7*scale, bt+6*scale], fill=fill)
    draw.ellipse([cx-18*scale, bt-8*scale, cx+18*scale, bt+38*scale], fill=bg)
    draw.rectangle([cx-bw//2, cy+18*scale, cx+bw//2, cy+34*scale], fill=bg)

def notification_dot(draw, cx, cy, r=10, fill=RED):
    draw.ellipse([cx-r, cy-r, cx+r, cy+r], fill=fill)

# ── scene factories ──────────────────────────────────────────────────────────

def scene_intro(t):
    """0-4s: logo + app name fade/slide in"""
    img = Image.new("RGBA", (W,H), (0,0,0,255))
    draw = ImageDraw.Draw(img)
    gradient_bg(draw)

    # Decorative circles
    draw.ellipse([W-240, -60, W+60, 240], fill=(255,255,255,15))
    draw.ellipse([-60, H-180, 180, H+60], fill=(255,255,255,10))

    t1 = min(t/1.2, 1.0)        # bell appears 0-1.2s
    t2 = max(0, (t-0.8)/1.2)    # text appears 0.8-2.0s
    t3 = max(0, (t-1.8)/1.0)    # tagline appears 1.8-2.8s

    # Bell (scale in)
    s = ease_out(t1)
    if s > 0:
        bx, by = W//2, H//2 - 60
        scaled_s = 0.3 + 0.7*s
        draw_bell(draw, bx, int(by), scale=1.6*scaled_s, bg=BLUE_MID)
        # notification dot
        ndot_alpha = int(255*s)
        dot_fill = (RED[0], RED[1], RED[2])
        notification_dot(draw, bx+70, by-115, r=int(14*scaled_s), fill=dot_fill)

    # App name slide up
    if t2 > 0:
        a = ease_out(t2)
        off = int((1-a)*40)
        alpha = int(255*a)
        bname = "DueMate"
        bbox = draw.textbbox((0,0), bname, font=F_TITLE)
        tw = bbox[2]-bbox[0]
        x = (W-tw)//2
        y = H//2 + 100 - off
        draw.text((x+2,y+2), bname, font=F_TITLE, fill=(0,0,0,60))
        draw.text((x,y), bname, font=F_TITLE, fill=WHITE)

    # Tagline
    if t3 > 0:
        a = ease_out(t3)
        off = int((1-a)*20)
        sub = "Smart Reminder"
        bbox = draw.textbbox((0,0), sub, font=F_SUB)
        tw = bbox[2]-bbox[0]
        x = (W-tw)//2
        y = H//2 + 206 - off
        draw.text((x,y), sub, font=F_SUB, fill=ACCENT)

    return img

def scene_tagline(t):
    """4-7s: tagline full screen"""
    img = Image.new("RGBA", (W,H), (0,0,0,255))
    draw = ImageDraw.Draw(img)
    gradient_bg(draw, BLUE_DARK, BLUE_MID)

    a = ease_out(min(t/0.8, 1.0))
    off = int((1-a)*30)

    lines = [
        ("Never miss a", F_MED, WHITE),
        ("due date again.", F_LARGE, ACCENT),
    ]
    total_h = 90 + 20
    start_y = H//2 - total_h//2 - off

    for i, (txt, fnt, col) in enumerate(lines):
        bbox = draw.textbbox((0,0), txt, font=fnt)
        tw = bbox[2]-bbox[0]
        x = (W-tw)//2
        y = start_y + i*100
        draw.text((x+2,y+2), txt, font=fnt, fill=(0,0,0,60))
        draw.text((x,y), txt, font=fnt, fill=col)

    return img

def feature_card(t, icon_char, title, body, accent_color):
    """Generic feature scene with card slide-in"""
    img = Image.new("RGBA", (W,H), (0,0,0,255))
    draw = ImageDraw.Draw(img)
    gradient_bg(draw, BLUE_DARK, BLUE_LIGHT)

    a = ease_out(min(t/0.9, 1.0))
    card_x_off = int((1-a)*120)

    # Card
    cx0, cy0 = 80 - card_x_off, 100
    cx1, cy1 = W-80 - card_x_off, H-100
    rounded_rect(draw, cx0, cy0, cx1, cy1, 24,
                 fill=(255,255,255,230))

    # Accent bar on left
    rounded_rect(draw, cx0, cy0, cx0+10, cy1, 5, fill=accent_color)

    # Icon circle
    ic_x, ic_y = cx0+90, (cy0+cy1)//2 - 20
    draw.ellipse([ic_x-50, ic_y-50, ic_x+50, ic_y+50], fill=accent_color)
    bbox = draw.textbbox((0,0), icon_char, font=F_MED)
    tw = bbox[2]-bbox[0]; th = bbox[3]-bbox[1]
    draw.text((ic_x-tw//2, ic_y-th//2-4), icon_char, font=F_MED, fill=WHITE)

    # Text
    tx = cx0 + 170
    draw.text((tx, cy0+80), title, font=F_MED, fill=DARK_TEXT)
    # Word-wrap body
    words = body.split()
    lines, line = [], ""
    for w in words:
        test = (line+" "+w).strip()
        bbox2 = draw.textbbox((0,0), test, font=F_BODY)
        if bbox2[2]-bbox2[0] > (cx1-tx-40):
            if line: lines.append(line)
            line = w
        else:
            line = test
    if line: lines.append(line)

    for i, ln in enumerate(lines):
        draw.text((tx, cy0+150+i*44), ln, font=F_BODY, fill=(80,80,80))

    return img

def scene_notification(t):
    """Notification preview scene"""
    img = Image.new("RGBA", (W,H), (0,0,0,255))
    draw = ImageDraw.Draw(img)
    gradient_bg(draw, BLUE_DARK, BLUE_MID)

    a = ease_out(min(t/0.8, 1.0))

    # Title
    text_center(draw, "Smart Notifications", H//2 - 220, F_MED)

    # Notification card mockup
    nc_w, nc_h = 680, 120
    nc_x = (W-nc_w)//2
    nc_y = H//2 - nc_h//2 + int((1-a)*60)

    rounded_rect(draw, nc_x, nc_y, nc_x+nc_w, nc_y+nc_h, 16,
                 fill=(255,255,255,240))

    # App icon mini bell
    bx2 = nc_x + 50
    by2 = nc_y + nc_h//2
    draw.ellipse([bx2-24, by2-24, bx2+24, by2+24], fill=BLUE_MID)
    draw.text((bx2-10, by2-14), "🔔", font=font(22), fill=WHITE)

    # Notification text
    draw.text((nc_x+90, nc_y+22), "DueMate", font=F_SMALL, fill=BLUE_MID)
    draw.text((nc_x+90, nc_y+50), "Electricity Bill due in 3 days", font=F_BODY, fill=DARK_TEXT)
    draw.text((nc_x+90, nc_y+86), "৳1,500 · Tap to view", font=F_TINY, fill=(120,120,120))

    # Time badge
    draw.text((nc_x+nc_w-80, nc_y+22), "now", font=F_TINY, fill=(150,150,150))

    # 2nd card (shifted)
    t2 = max(0, (t-0.4)/0.6)
    a2 = ease_out(min(t2, 1.0))
    nc2_y = nc_y + nc_h + 20 + int((1-a2)*40)
    rounded_rect(draw, nc_x, nc2_y, nc_x+nc_w, nc2_y+nc_h, 16,
                 fill=(255,255,255,200))
    draw.ellipse([bx2-24, nc2_y+nc_h//2-24, bx2+24, nc2_y+nc_h//2+24], fill=BLUE_MID)
    draw.text((nc_x+90, nc2_y+22), "DueMate", font=F_SMALL, fill=BLUE_MID)
    draw.text((nc_x+90, nc2_y+50), "Netflix Subscription expires tomorrow", font=F_BODY, fill=DARK_TEXT)
    draw.text((nc_x+90, nc2_y+86), "৳649 · Tap to view", font=F_TINY, fill=(120,120,120))

    # subtitle
    t3 = max(0, (t-0.9)/0.6)
    a3 = ease_out(min(t3,1.0))
    sub = "Get reminded 1, 3, or 7 days before every due date"
    bbox = draw.textbbox((0,0), sub, font=F_SMALL)
    tw = bbox[2]-bbox[0]
    draw.text(((W-tw)//2, nc2_y+nc_h+36), sub, font=F_SMALL,
              fill=(255,255,255,int(220*a3)))

    return img

def scene_cta(t):
    """Final CTA"""
    img = Image.new("RGBA", (W,H), (0,0,0,255))
    draw = ImageDraw.Draw(img)
    gradient_bg(draw, BLUE_DARK, BLUE_LIGHT)

    draw.ellipse([W-200, -50, W+50, 200], fill=(255,255,255,18))
    draw.ellipse([-50, H-150, 150, H+50], fill=(255,255,255,12))

    a = ease_out(min(t/1.0, 1.0))
    off = int((1-a)*40)

    bx2, by2 = W//2, H//2 - 80 - off
    draw_bell(draw, bx2, by2, scale=1.4, bg=BLUE_MID)
    notification_dot(draw, bx2+62, by2-100, r=12, fill=RED)

    text_center(draw, "DueMate", H//2 + 20 - off, F_TITLE)
    text_center(draw, "Smart Reminder", H//2 + 130 - off, F_SUB, fill=ACCENT)

    t2 = max(0, (t-0.8)/0.8)
    a2 = ease_out(min(t2,1.0))
    # Green "Available on Google Play" pill
    pill_w, pill_h = 480, 68
    pill_x = (W-pill_w)//2
    pill_y = H//2 + 196 + int((1-a2)*30)
    rounded_rect(draw, pill_x, pill_y, pill_x+pill_w, pill_y+pill_h,
                 pill_h//2, fill=GREEN)
    cta = "Available on Google Play"
    bbox = draw.textbbox((0,0), cta, font=F_BODY)
    tw = bbox[2]-bbox[0]
    draw.text(((W-tw)//2, pill_y+14), cta, font=F_BODY, fill=WHITE)

    return img

# ── timeline ─────────────────────────────────────────────────────────────────
# (start_sec, duration_sec, func)
SCENES = [
    (0.0,  4.0, lambda t: scene_intro(t)),
    (4.0,  3.0, lambda t: scene_tagline(t)),
    (7.0,  5.0, lambda t: feature_card(t, "$", "Bills & Payments",
                "Track electricity, water, internet and all monthly bills in one place.",
                (244, 67, 54))),
    (12.0, 5.0, lambda t: feature_card(t, "↺", "Subscriptions",
                "Never let a streaming, software or SaaS subscription slip past its renewal date.",
                (156, 39, 176))),
    (17.0, 5.0, lambda t: feature_card(t, "📄", "Documents & Warranties",
                "Passport, NID, insurance policies, warranty cards — all expiry dates tracked.",
                (0, 150, 136))),
    (22.0, 6.0, lambda t: scene_notification(t)),
    (28.0, 6.0, lambda t: scene_cta(t)),
]

TOTAL = 34  # seconds

# ── render ───────────────────────────────────────────────────────────────────
fourcc = cv2.VideoWriter_fourcc(*"mp4v")
writer = cv2.VideoWriter(OUT, fourcc, FPS, (W, H))

total_frames = TOTAL * FPS
print(f"Rendering {total_frames} frames ({TOTAL}s @ {FPS}fps)…")

for f in range(total_frames):
    sec = f / FPS
    img = None
    for (start, dur, fn) in SCENES:
        if start <= sec < start + dur:
            t_local = (sec - start) / dur
            img = fn(t_local)
            break
    if img is None:
        img = scene_cta(1.0)   # hold last frame

    # Fade in/out
    fade_dur = 0.4
    alpha = 1.0
    if sec < fade_dur:
        alpha = sec / fade_dur
    elif sec > TOTAL - fade_dur:
        alpha = (TOTAL - sec) / fade_dur
    if alpha < 1.0:
        black = Image.new("RGBA", (W,H), (0,0,0,255))
        img = Image.blend(black, img.convert("RGBA"), alpha)

    writer.write(pil_to_cv(img))

    if f % (FPS*5) == 0:
        print(f"  {sec:.0f}s / {TOTAL}s")

writer.release()
print(f"\nSaved: {OUT}")
