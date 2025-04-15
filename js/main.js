// Navbar scroll effect
window.addEventListener('scroll', function() {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 50) {
        navbar.classList.add('scrolled');
    } else {
        navbar.classList.remove('scrolled');
    }
});

// Smooth scroll for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            window.scrollTo({
                top: target.offsetTop - 70,
                behavior: 'smooth'
            });
        }
    });
});

// Animation on scroll
window.addEventListener('scroll', function() {
    const elements = document.querySelectorAll('.animate-on-scroll');
    elements.forEach(element => {
        const position = element.getBoundingClientRect();
        if(position.top < window.innerHeight - 100) {
            element.classList.add('animated');
        }
    });
});

// Service and Equipment card interactions
function toggleDetails(id, type) {
    const details = document.getElementById(`${id}-details`);
    const allDetails = document.querySelectorAll(`.${type}-details`);
    
    allDetails.forEach(detail => {
        if (detail.id !== `${id}-details`) {
            detail.style.display = 'none';
        }
    });
    
    details.style.display = details.style.display === 'none' ? 'block' : 'none';
}