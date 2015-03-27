function Search(url, searchTagID, resultID) {
	this.url = url;
	this.searchTagID = searchTagID;
	this.resultID = resultID;
	var obj = this;
	document.getElementById(searchTagID).onkeyup = function(event) {
		obj.keyup(event);
	}
}

Search.prototype.keyup = function(event) {
	var obj = this;
	var search = document.getElementById(this.searchTagID).value;

	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function() {
		if (this.readyState == 4) {
			if (this.status == 200) {
				document.getElementById(obj.resultID).innerHTML = this.responseText;
			}
			else {
				return;
			}
		}
	}
	xhr.open("GET", this.url + "?" + this.searchTagID + "=" + encodeURIComponent(search));
	xhr.send();
	return false;
}