
let menuBtn = document.querySelector('.menu-btn');
let menu = document.querySelector('.menu');
let cross = document.querySelector('.nav__cross');

menuBtn.addEventListener('click', function(){
	menuBtn.classList.toggle('active');
	menu.classList.toggle('active');
	cross.classList.toggle('active');
});

cross.addEventListener('click',function(){
	menuBtn.classList.toggle('active');
	menu.classList.toggle('active');
	cross.classList.toggle('active');

});

window.onscroll = function () { myFunction() };

// Get the navbar
var navbar = document.querySelector('.jaw');

// Get the offset position of the navbar
var sticky = navbar.offsetTop;

var navRow = document.querySelector('.jaw__row');

// Add the sticky class to the navbar when you reach its scroll position. Remove "sticky" when you leave the scroll position
function myFunction() {
	if (window.pageYOffset >= sticky) {
		navbar.classList.add("sticky")
		navRow.classList.add('centerRow')

	} else {
		navbar.classList.remove("sticky");
		navRow.classList.remove('centerRow')
	}
};

let coll = document.getElementsByClassName('drop__btn');
for (let i = 0; i < coll.length; i++) {
	coll[i].addEventListener('click', function () {
		this.classList.toggle('active');
		let content = this.nextElementSibling;
		if (content.style.maxHeight) {
			content.style.maxHeight = null;
			content.classList.remove('border');
		} else {
			content.style.maxHeight = content.scrollHeight + 40 + 'px'
			content.classList.add('border');
		}

	});
};
