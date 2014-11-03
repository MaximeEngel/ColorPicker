// Wheel mouse listener
function wheelHandleMouse(mouse) {
    if (mouse.buttons & Qt.LeftButton) {

        // cartesian to polar coords
        var ro = Math.sqrt(Math.pow(mouse.x-root.width/2,2)+Math.pow(mouse.y-root.height/2,2));
        var theta = Math.atan2(((mouse.y-root.height/2)*(-1)),((mouse.x-root.width/2)));

        // Wheel limit
        if(ro > root.width/2)
            ro = root.width/2;

        // polar to cartesian coords
        pickerCursor.x = Math.max(0-pickerCursor.r, Math.min(width, ro*Math.cos(theta)+root.width/2)-pickerCursor.r);
        pickerCursor.y = Math.max(0-pickerCursor.r, Math.min(height, root.height/2-ro*Math.sin(theta)-pickerCursor.r));

        // set hsba values
        hue.value = Math.ceil((wheel.hueColor/(Math.PI*2)+0.5)*100)/100;
        sat.value = Math.ceil(ro/wheel.height*2*100)/100;
        brightness.value = brightnessPicker.brightness;
        hsbAlpha.value = alphaPicker.alpha;

        // construct the #AARRGGBB color
        wheel.color = hsba(hue.value, sat.value, brightness.value, hsbAlpha.value);
        console.log(getChannelStr(currentColor.text,0).toString(16)+wheel.color.substr(1, 6));

    }
}

// Text input listener
function currentColorChanged(text){

    // rgba values
    rgbAlpha.value = getChannelStr(text, 0);
    red.value = getChannelStr(text, 1);
    green.value = getChannelStr(text, 2);
    blue.value = getChannelStr(text, 3);

    // color display
    colorDisplay.color = text;

    // brightness slider color
    brightnessBeginColor.color = "#FF"+text.substr(3, 6);

    // alpha slider color
    alphaBeginColor.color = "#FF"+text.substr(3, 6);
}

// alpha slider listener
function SliderHandleMouse(mouse, name){
    if (mouse.buttons & Qt.LeftButton) {
        pickerCursor.y = Math.max(0, Math.min(height, mouse.y));

        if(name === "alphaSlider"){
            var hsbAlphaValue = Math.ceil(pickerCursor.y / height * 100) / 100;
            hsbAlpha.value = 1 - hsbAlphaValue;
            rgbAlpha.value = 255 - Math.ceil(hsbAlphaValue * 255);

        }

        if(name === "brightnessSlider"){
            var brightnessValue = 1-Math.ceil(pickerCursor.y / height * 100) / 100;
            brightness.value = brightnessValue;
        }
    }
}

// creates color value from hue, saturation, brightness, alpha
function hsba(h, s, b, a) {
    var lightness = (2 - s)*b;
    var satHSL = s*b/((lightness <= 1) ? lightness : 2 - lightness);
    lightness /= 2;
    return Qt.hsla(h, satHSL, lightness, a);
}

// creates a full color string from color value and alpha[0..1], e.g. "#FF00FF00"
function fullColorString(clr, a) {
    return "#" + ((Math.ceil(a*255) + 256).toString(16).substr(1, 2) +
                  clr.toString().substr(1, 6)).toUpperCase();
}

// extracts integer color channel value [0..255] from color value
function getChannelStr(clr, channelIdx) {
    return parseInt(clr.toString().substr(channelIdx*2 + 1, 2), 16);
}
