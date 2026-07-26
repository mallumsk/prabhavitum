/**
 * Prabhavitum PU Science College — Interactive Application Scripts
 */

document.addEventListener('DOMContentLoaded', () => {
  initNavigation();
  initSystemThemeToggle();
  initCourseModals();
  initGalleryFilters();
  initFormHandling();
});

/* -------------------------------------------------------------------------- */
/* 1. Multi-Page View Navigation (SPA)                                       */
/* -------------------------------------------------------------------------- */
function initNavigation() {
  const navLinks = document.querySelectorAll('.nav-link, .spa-navigate');
  const pageViews = document.querySelectorAll('.page-view');
  const mobileToggle = document.getElementById('mobileNavToggle');
  const navMenu = document.getElementById('navMenu');

  function navigateTo(pageId) {
    const targetId = pageId.replace('#', '') || 'home';
    
    // Hide all page views
    pageViews.forEach(view => {
      view.classList.remove('active');
    });

    // Show selected target page view
    const activeView = document.getElementById(`page-${targetId}`);
    if (activeView) {
      activeView.classList.add('active');
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    // Update active state on nav links
    document.querySelectorAll('.nav-link').forEach(link => {
      link.classList.remove('active');
      if (link.getAttribute('data-target') === targetId) {
        link.classList.add('active');
      }
    });

    // Close mobile drawer if open
    if (navMenu) navMenu.classList.remove('active');
  }

  // Handle click on nav links
  navLinks.forEach(link => {
    link.addEventListener('click', (e) => {
      e.preventDefault();
      const target = link.getAttribute('data-target') || link.getAttribute('href');
      if (target) {
        window.location.hash = target.replace('#', '');
        navigateTo(target);
      }
    });
  });

  // Handle browser back/forward buttons or initial load hash
  window.addEventListener('hashchange', () => {
    navigateTo(window.location.hash);
  });

  if (window.location.hash) {
    navigateTo(window.location.hash);
  } else {
    navigateTo('home');
  }

  // Mobile Menu Toggle
  if (mobileToggle && navMenu) {
    mobileToggle.addEventListener('click', () => {
      navMenu.classList.toggle('active');
    });
  }
}

/* -------------------------------------------------------------------------- */
/* 2. Theme Mode Toggle (Default Light/White Theme)                           */
/* -------------------------------------------------------------------------- */
function initSystemThemeToggle() {
  const themeToggleBtn = document.getElementById('themeToggleBtn');
  const savedTheme = localStorage.getItem('prabhavitum-theme');
  
  // Default explicitly to 'light' (white header, body, footer) unless user toggled 'dark'
  const initialTheme = savedTheme ? savedTheme : 'light';

  applyTheme(initialTheme);

  if (themeToggleBtn) {
    themeToggleBtn.addEventListener('click', () => {
      const currentTheme = document.documentElement.getAttribute('data-theme') === 'dark' ? 'dark' : 'light';
      const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
      
      applyTheme(newTheme);
      localStorage.setItem('prabhavitum-theme', newTheme);
    });
  }
}

function applyTheme(theme) {
  const themeIcon = document.getElementById('themeIcon');
  if (theme === 'dark') {
    document.documentElement.setAttribute('data-theme', 'dark');
    if (themeIcon) themeIcon.className = 'fas fa-moon';
  } else {
    document.documentElement.removeAttribute('data-theme');
    if (themeIcon) themeIcon.className = 'fas fa-sun';
  }
}

/* -------------------------------------------------------------------------- */
/* 3. Course Details Modal                                                    */
/* -------------------------------------------------------------------------- */
const courseData = {
  science_neet: {
    title: "PUC Science + NEET",
    stream: "PCMB (Physics, Chemistry, Mathematics, Biology)",
    coaching: "Integrated Medical Entrance (NEET-UG) Coaching",
    duration: "2 Years (PUC I & PUC II)",
    eligibility: "Pass in SSLC / Class 10th or equivalent recognized board examination.",
    description: "This flagship program is engineered for students aspiring to excel in medical admissions. It combines the core Karnataka State PU Board curriculum with intensive, concept-driven coaching for NEET-UG.",
    highlights: [
      "Daily practice papers (DPPs) & chapter-wise mock tests",
      "Special emphasis on NCERT Biology & Organic Chemistry",
      "Small batch sizes for personalized doubt clearing",
      "Regular progress reporting for parents"
    ]
  },
  science_jee: {
    title: "PUC Science + JEE & KCET",
    stream: "PCMB / PCMC (Physics, Chemistry, Math, Biology / Computer Science)",
    coaching: "IIT-JEE (Main) & KCET Engineering Entrance",
    duration: "2 Years (PUC I & PUC II)",
    eligibility: "Pass in SSLC / Class 10th with strong mathematics foundation.",
    description: "Designed for future engineers, researchers, and tech leaders. The course integrates analytical mathematics and practical physics with exam strategies for IIT-JEE and KCET.",
    highlights: [
      "Advanced problem-solving techniques in Physics & Math",
      "Full-length KCET speed tests & JEE mock series",
      "Hands-on lab practicals aligned with entrance syllabus",
      "Mentoring by experienced senior faculty"
    ]
  },
  commerce_ca: {
    title: "PUC Commerce + CA Foundation",
    stream: "HEBA / CEBA (History/CS, Economics, Business Studies, Accountancy)",
    coaching: "Integrated CA Foundation Professional Coaching",
    duration: "2 Years (PUC I & PUC II)",
    eligibility: "Pass in SSLC / Class 10th examination.",
    description: "A premier program tailored for future Chartered Accountants, financial analysts, and corporate leaders. Combines solid commerce fundamentals with systematic CA Foundation guidance.",
    highlights: [
      "In-depth coverage of Accounting & Mercantile Laws",
      "Quantitative Aptitude & Business Economics modules",
      "Regular guest lectures by professional CAs",
      "Career counselling for B.Com, BBA, and CA paths"
    ]
  }
};

function initCourseModals() {
  const modalBackdrop = document.getElementById('courseModalBackdrop');
  const closeModalBtn = document.getElementById('modalCloseBtn');
  const courseButtons = document.querySelectorAll('.view-course-detail');

  if (!modalBackdrop) return;

  courseButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const courseId = btn.getAttribute('data-course');
      const data = courseData[courseId];
      if (data) {
        document.getElementById('modalTitle').textContent = data.title;
        document.getElementById('modalStream').textContent = data.stream;
        document.getElementById('modalCoaching').textContent = data.coaching;
        document.getElementById('modalDuration').textContent = data.duration;
        document.getElementById('modalEligibility').textContent = data.eligibility;
        document.getElementById('modalDescription').textContent = data.description;

        const highlightsList = document.getElementById('modalHighlights');
        highlightsList.innerHTML = '';
        data.highlights.forEach(h => {
          const li = document.createElement('li');
          li.innerHTML = `<i class="fas fa-check-circle text-emerald"></i> ${h}`;
          highlightsList.appendChild(li);
        });

        modalBackdrop.classList.add('active');
      }
    });
  });

  closeModalBtn.addEventListener('click', () => {
    modalBackdrop.classList.remove('active');
  });

  modalBackdrop.addEventListener('click', (e) => {
    if (e.target === modalBackdrop) {
      modalBackdrop.classList.remove('active');
    }
  });
}

/* -------------------------------------------------------------------------- */
/* 4. Gallery Category Filter                                                 */
/* -------------------------------------------------------------------------- */
function initGalleryFilters() {
  const filterBtns = document.querySelectorAll('.gallery-filter-btn');
  const galleryItems = document.querySelectorAll('.gallery-item');

  filterBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      filterBtns.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');

      const filter = btn.getAttribute('data-filter');

      galleryItems.forEach(item => {
        const category = item.getAttribute('data-category');
        if (filter === 'all' || category === filter) {
          item.style.display = 'block';
        } else {
          item.style.display = 'none';
        }
      });
    });
  });
}

/* -------------------------------------------------------------------------- */
/* 5. Contact & Enquiry Form Handling                                        */
/* -------------------------------------------------------------------------- */
function initFormHandling() {
  const enquiryForm = document.getElementById('enquiryForm');

  if (enquiryForm) {
    enquiryForm.addEventListener('submit', (e) => {
      e.preventDefault();
      
      const name = document.getElementById('studentName')?.value;
      const course = document.getElementById('interestedCourse')?.value;

      showToast(`Thank you, ${name || 'Student'}! Your enquiry for ${course || 'PUC Admissions'} has been submitted successfully. Our team will contact you shortly.`);
      
      enquiryForm.reset();
    });
  }
}

function showToast(message) {
  const toastContainer = document.getElementById('toastContainer');
  if (!toastContainer) return;

  const toast = document.createElement('div');
  toast.className = 'toast';
  toast.innerHTML = `<i class="fas fa-check-circle" style="color: var(--brand-green); font-size: 1.2rem;"></i> <span>${message}</span>`;

  toastContainer.appendChild(toast);

  setTimeout(() => {
    toast.style.opacity = '0';
    toast.style.transform = 'translateY(20px)';
    setTimeout(() => toast.remove(), 300);
  }, 4500);
}
