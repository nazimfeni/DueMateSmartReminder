from PIL import Image, ImageDraw, ImageFont
import math

SIZE = 512
BLUE = (21, 101, 192)       # #1565C0
WHITE = (255, 255, 255)
CORNER = 80

img = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
draw = ImageDraw.Draw(img)

# Rounded blue background
def rounded_rect(draw, xy, radius, fill):
    x0, y0, x1, y1 = xy
    draw.rectangle([x0+radius, y0, x1-radius, y1], fill=fill)
    draw.rectangle([x0, y0+radius, x1, y1-radius], fill=fill)
    draw.ellipse([x0, y0, x0+2*radius, y0+2*radius], fill=fill)
    draw.ellipse([x1-2*radius, y0, x1, y0+2*radius], fill=fill)
    draw.ellipse([x0, y1-2*radius, x0+2*radius, y1], fill=fill)
    draw.ellipse([x1-2*radius, y1-2*radius, x1, y1], fill=fill)

rounded_rect(draw, [0, 0, SIZE, SIZE], CORNER, BLUE)

# Bell icon — centered, white
cx, cy = SIZE // 2, SIZE // 2 - 20
scale = 7.5

# Bell body (arc + straight sides)
bell_top_y = int(cy - 90)
bell_w = int(130)
bell_h = int(120)

# Bell arc (dome)
draw.ellipse([cx - bell_w//2, bell_top_y, cx + bell_w//2, bell_top_y + bell_h + 20], fill=WHITE)
# Bell body rectangle
draw.rectangle([cx - bell_w//2, bell_top_y + bell_h//2, cx + bell_w//2, cy + 60], fill=WHITE)
# Bell flare (bottom)
draw.ellipse([cx - bell_w//2 - 20, cy + 40, cx + bell_w//2 + 20, cy + 90], fill=WHITE)

# Clapper (circle at bottom)
draw.ellipse([cx - 22, cy + 70, cx + 22, cy + 114], fill=WHITE)

# Stem (top of bell)
draw.rectangle([cx - 12, bell_top_y - 24, cx + 12, bell_top_y + 10], fill=WHITE)

# Notch cutout at top of dome to separate from stem
draw.ellipse([cx - 30, bell_top_y - 10, cx + 30, bell_top_y + 50], fill=BLUE)

# Bell hole at bottom center (makes it look like a bell)
draw.rectangle([cx - bell_w//2, cy + 60, cx + bell_w//2, cy + 80], fill=BLUE)

# DM monogram below bell — small text substitute using shapes
# "D" shape
dm_y = cy + 120
dm_x = cx - 36
# Simple "DM" using rectangles
draw.rectangle([dm_x, dm_y, dm_x+8, dm_y+36], fill=WHITE)
draw.ellipse([dm_x, dm_y, dm_x+32, dm_y+36], fill=WHITE)
draw.ellipse([dm_x+4, dm_y+6, dm_x+24, dm_y+30], fill=BLUE)

# "M" shape
mx = cx + 6
draw.rectangle([mx, dm_y, mx+8, dm_y+36], fill=WHITE)
draw.rectangle([mx+20, dm_y, mx+28, dm_y+36], fill=WHITE)
draw.polygon([(mx, dm_y), (mx+14, dm_y+18), (mx+28, dm_y)], fill=WHITE)

img.save(r"D:\flutter_projects\DueMateSmartReminder\screenshots\play_store_icon_512.png")
print("Icon saved: play_store_icon_512.png")
print(f"Size: {img.size}")
