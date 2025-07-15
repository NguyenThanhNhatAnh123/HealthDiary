function showSection(sectionId) {
    // Ẩn tất cả các section
    document.querySelectorAll('.content-section').forEach(function(section) {
        section.classList.remove('active');
    });
	
    var section = document.getElementById(sectionId);
    if (section) section.classList.add('active');

    // Đổi trạng thái active cho menu
    document.querySelectorAll('.nav-link').forEach(function(link) {
        link.classList.remove('active');
    });
    var navLink = document.querySelector('.nav-link[href="#' + sectionId + '"]');
    if (navLink) navLink.classList.add('active');
}
