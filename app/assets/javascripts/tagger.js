function Tagger(id, tagid, left, top, width, height) {
    this.id = id;
    this.tagid = tagid;
    this.isMouseDown = false;
    this.tapleft = document.getElementById(left);
    this.taptop = document.getElementById(top);
    this.tapwidth = document.getElementById(width);
    this.tapheight = document.getElementById(height);
    this.element = document.getElementById(id);
    var obj = this;
    this.element.onmousedown = function(event) {
        obj.mouseDown(event);
    }
}

Tagger.prototype.mouseDown = function(event) {
    var obj = this;
    this.oldMoveHandler = document.body.onmousemove;
    this.oldX = event.pageX;
    this.oldY = event.pageY;
    document.onmousemove = function(event) {
        obj.mouseMove(event);
    }
    this.oldUpHandler = document.body.onmouseup;
    document.onmouseup = function(event) {
        obj.mouseUp(event);
    }
    this.isMouseDown = true;
    event.preventDefault();
}

Tagger.prototype.mouseMove = function(event) {
   if (!this.isMouseDown) {
       return;
   }

    var ele = document.getElementById(this.id);
    var n = document.getElementById(this.tagid);
    n.style.backgroundColor = 'transparent';
    n.style.position = "absolute";
    n.style.border = "1px solid #5050f0";

    n.style.left = Math.min(event.pageX, this.oldX) - this.element.offsetLeft + "px";
    n.style.top = Math.min(event.pageY, this.oldY) - this.element.offsetTop + "px";
    if (event.pageX > this.element.offsetLeft && event.pageX < this.element.offsetLeft + this.element.offsetWidth) {
        n.style.width = Math.abs(event.pageX  - this.oldX) - 2 + "px";
    } else if (event.pageX <= this.element.offsetLeft) {
        n.style.width = Math.abs(this.element.offsetLeft - this.oldX ) - 2 + "px"; 
        n.style.left = 0 + "px";
    } else {        
        n.style.width = Math.abs(this.element.offsetLeft + this.element.offsetWidth - this.oldX ) - 2 + "px";
    }
    
    if (event.pageY > this.element.offsetTop && event.pageY < this.element.offsetTop + this.element.offsetHeight) {
        n.style.height = Math.abs(event.pageY - this.oldY) + "px";
    } else if (event.pageY <= this.element.offsetTop) {
        n.style.height = Math.abs(this.element.offsetTop - this.oldY ) + "px"; 
        n.style.top = 0 + "px";
    } else {
        n.style.height = Math.abs(this.element.offsetTop + this.element.offsetHeight - this.oldY ) + "px";   
    }

}

Tagger.prototype.mouseUp = function(event) {
    this.isMouseDown = false;
    document.onmousemove = this.oldMoveHandler;
    document.onmouseup = this.oldUpHandler;
    this.tapleft.value = document.getElementById(this.tagid).style.left;
    this.taptop.value = document.getElementById(this.tagid).style.top;
    this.tapwidth.value = document.getElementById(this.tagid).style.width;
    this.tapheight.value = document.getElementById(this.tagid).style.height;
}