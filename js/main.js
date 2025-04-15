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
document.addEventListener('DOMContentLoaded', function() {
    const navLinks = document.querySelectorAll('.nav-link');
    
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            // Remove active class from all links
            navLinks.forEach(l => l.classList.remove('active'));
            // Add active class to clicked link
            this.classList.add('active');
            
            // Scroll to section with offset
            const targetId = this.getAttribute('href');
            if (targetId !== '#') {
                const targetSection = document.querySelector(targetId);
                const offset = 100;
                const targetPosition = targetSection.offsetTop - offset;
                
                window.scrollTo({
                    top: targetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });
    
    // Highlight active section on scroll
    window.addEventListener('scroll', function() {
        const scrollPosition = window.scrollY + 100;
        
        document.querySelectorAll('section').forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.offsetHeight;
            const sectionId = section.getAttribute('id');
            
            if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
                navLinks.forEach(link => {
                    link.classList.remove('active');
                    if (link.getAttribute('href') === `#${sectionId}`) {
                        link.classList.add('active');
                    }
                });
            }
        });
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