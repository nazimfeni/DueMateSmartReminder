from PIL import Image, ImageDraw, ImageFont
import math

W, H = 1024, 500
BLUE_DARK  = (13, 71, 161)   # #0D47A1
BLUE_MID   = (21, 101, 192)  # #1565C0
BLUE_LIGHT = (30, 136, 229)  # #1E88E5
WHITE      = (255, 255, 255)
WHITE_80   = (255, 255, 255, 204)
ACCENT     = (100, 181, 246)  # #64B5F6

img = Image.new("RGBA", (W, H), BLUE_MID)
draw = ImageDraw.Draw(img)

# Gradient background — vertical bands
for x in range(W):
    t = x / W
    r = int(BLUE_DARK[0] + (BLUE_LIGHT[0] - BLUE_DARK[0]) * t)
    g = int(BLUE_DARK[1] + (BLUE_LIGHT[1] - BLUE_DARK[1]) * t)
    b = int(BLUE_DARK[2] + (BLUE_LIGHT[2] - BLUE_DARK[2]) * t)
    draw.line([(x, 0), (x, H)], fill=(r, g, b))

# Decorative circles (subtle)
draw.ellipse([W - 280, -80, W + 80, 280], fill=(255, 255, 255, 18), outline=None)
draw.ellipse([W - 200, -20, W + 20, 200], fill=(255, 255, 255, 12), outline=None)
draw.ellipse([-60, H - 200, 200, H + 60], fill=(255, 255, 255, 12), outline=None)

# Bell icon — left side, centered vertically
bx, by = 160, H // 2
bell_w, bell_h = 100, 90

# Bell dome
draw.ellipse([bx - bell_w//2, by - 110, bx + bell_w//2, by - 110 + bell_h + 16], fill=WHITE)
# Bell body
draw.rectangle([bx - bell_w//2, by - 110 + bell_h//2, bx + bell_w//2, by + 30], fill=WHITE)
# Bell flare
draw.ellipse([bx - bell_w//2 - 16, by + 15, bx + bell_w//2 + 16, by + 55], fill=WHITE)
# Clapper
draw.ellipse([bx - 16, by + 42, bx + 16, by + 76], fill=WHITE)
# Stem
draw.rectangle([bx - 9, by - 130, bx + 9, by - 110 + 8], fill=WHITE)
# Notch cutout
draw.ellipse([bx - 22, by - 118, bx + 22, by - 70], fill=BLUE_MID)
# Bell bottom cutout
draw.rectangle([bx - bell_w//2, by + 28, bx + bell_w//2, by + 44], fill=BLUE_MID)

# Notification dot on bell
dot_x, dot_y = bx + bell_w//2 - 4, by - 110 + 10
draw.ellipse([dot_x - 14, dot_y - 14, dot_x + 14, dot_y + 14], fill=(255, 82, 82))

# Try to use a system font, fall back to default
def get_font(size, bold=False):
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

font_title  = get_font(72, bold=True)
font_sub    = get_font(34)
font_tag    = get_font(26)

# App name — right of bell
tx = 290
ty = H // 2 - 70

draw.text((tx, ty), "DueMate", font=font_title, fill=WHITE)
# "Smart Reminder" slightly smaller, below
draw.text((tx, ty + 82), "Smart Reminder", font=font_sub, fill=ACCENT)

# Tagline
draw.text((tx, ty + 130), "Never miss a due date again", font=font_tag, fill=(255, 255, 255, 190))

# Small pill badges at bottom-right
badges = ["Bills", "Subscriptions", "Documents", "Warranties"]
px, py = W - 20, H - 56
for badge in reversed(badges):
    bbox = draw.textbbox((0, 0), badge, font=get_font(22))
    bw = bbox[2] - bbox[0] + 28
    bh = 36
    px -= bw + 10
    rx0, ry0, rx1, ry1 = px, py, px + bw, py + bh
    # Rounded pill
    r = bh // 2
    draw.rectangle([rx0 + r, ry0, rx1 - r, ry1], fill=(255, 255, 255, 50))
    draw.ellipse([rx0, ry0, rx0 + 2*r, ry1], fill=(255, 255, 255, 50))
    draw.ellipse([rx1 - 2*r, ry0, rx1, ry1], fill=(255, 255, 255, 50))
    draw.text((rx0 + 14, ry0 + 6), badge, font=get_font(22), fill=WHITE)

out = r"D:\flutter_projects\DueMateSmartReminder\screenshots\play_store_feature_graphic.png"
img.save(out)
print(f"Saved: {out}")
print(f"Size: {img.size}")
