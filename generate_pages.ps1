
# PowerShell script to generate all template detail pages
$basePath = "c:\Users\noman\Downloads\NEW\Landing Page Portfolio\templates"
New-Item -ItemType Directory -Force -Path $basePath | Out-Null

function Get-DetailPage {
    param($p)
    
    $featuresHtml = ($p.features | ForEach-Object { 
        "<li><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2.5' stroke-linecap='round' stroke-linejoin='round'><polyline points='20 6 9 17 4 12'></polyline></svg><span>$_</span></li>"
    }) -join "`n                                "

    $techDetailsHtml = ($p.techStackDetails | ForEach-Object { 
        "<li><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2.5' stroke-linecap='round' stroke-linejoin='round'><polyline points='16 18 22 12 16 6'></polyline><polyline points='8 6 2 12 8 18'></polyline></svg><span>$_</span></li>"
    }) -join "`n                                "

    $techPillsHtml = ($p.tech | ForEach-Object { "<span class='tech-pill'>$_</span>" }) -join "`n                                "

return @"
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$($p.name) — ThemeMint</title>
    <meta name="description" content="$($p.shortDesc)">
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Space+Grotesk:wght@300;500;700&display=swap" rel="stylesheet">
    <!-- Shared Styles -->
    <link rel="stylesheet" href="../shared.css">
</head>

<body>

    <!-- Navigation -->
    <nav id="navbar">
        <div class="container">
            <div class="nav-content">
                <a href="../index.html" class="logo">
                    <img src="../Logo.png" alt="ThemeMint Logo">
                </a>
                <ul class="nav-links">
                    <li><a href="../index.html#home">Home</a></li>
                    <li><a href="../index.html#portfolio">Portfolio</a></li>
                    <li><a href="../index.html#about">About</a></li>
                    <li><a href="../index.html#contact">Contact</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Preview -->
    <section class="detail-hero">
        <div class="iframe-wrapper" id="heroWrapper">
            <iframe id="heroIframe" src="$($p.link)" loading="eager" onload="this.parentElement.classList.add('loaded')"></iframe>
        </div>
        <div class="detail-hero-overlay"></div>
    </section>

    <!-- Header -->
    <div class="detail-header">
        <div class="container">
            <div class="detail-header-inner">
                <div class="detail-title-group" data-reveal>
                    <span class="badge">$($p.category)</span>
                    <h1>$($p.name)</h1>
                    <p class="tagline">$($p.tagline)</p>
                </div>
                <div class="detail-header-actions" data-reveal>
                    <a href="$($p.link)" target="_blank" class="btn btn-primary">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                        Live Preview
                    </a>
                    <a href="../index.html#portfolio" class="btn btn-secondary">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>
                        Back to Portfolio
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <main class="detail-content">
        <div class="container">
            <div class="detail-grid">

                <!-- Left Column -->
                <div>
                    <div class="detail-section" data-reveal>
                        <h2>Overview</h2>
                        <p>$($p.description)</p>
                    </div>

                    <div class="detail-section" data-reveal>
                        <h2>The Challenge</h2>
                        <p>$($p.problem)</p>
                    </div>

                    <div class="detail-section" data-reveal>
                        <h2>Our Solution</h2>
                        <p>$($p.solution)</p>
                    </div>

                    <div class="detail-section" data-reveal>
                        <h2>Key Features</h2>
                        <ul class="feature-list">
                                $featuresHtml
                        </ul>
                    </div>

                    <div class="detail-section" data-reveal>
                        <h2>Technology Stack</h2>
                        <ul class="feature-list" style="margin-bottom: 1.5rem;">
                                $techDetailsHtml
                        </ul>
                        <div class="tech-pills">
                                $techPillsHtml
                        </div>
                    </div>
                </div>

                <!-- Right Sidebar -->
                <div data-reveal>
                    <div class="detail-sidebar-card">
                        <h3>Category</h3>
                        <p>$($p.category)</p>
                        <div class="divider"></div>
                        <h3>Target Audience</h3>
                        <p>$($p.audience)</p>
                        <div class="divider"></div>
                        <div class="sidebar-btn-group">
                            <a href="$($p.link)" target="_blank" class="btn btn-primary">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                                Live Preview
                            </a>
                            <a href="../index.html#portfolio" class="btn btn-secondary">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>
                                Back to Portfolio
                            </a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer id="contact">
        <div class="container">
            <div class="footer-content">
                <div class="footer-logo">
                    <img src="../Logo.png" alt="ThemeMint Logo">
                </div>
                <div class="footer-links">
                    <a href="#">Twitter</a>
                    <a href="#">LinkedIn</a>
                    <a href="#">Instagram</a>
                    <a href="#">Dribbble</a>
                </div>
                <p style="color: var(--text-dim); font-size: 0.8rem;">&copy; 2024 ThemeMint Studio. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Back to Top -->
    <button class="back-to-top" id="backToTop" onclick="window.scrollTo({top:0,behavior:'smooth'})">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="19" x2="12" y2="5"></line><polyline points="5 12 12 5 19 12"></polyline></svg>
    </button>

    <script>
        // Navbar scroll effect
        const navbar = document.getElementById('navbar');
        const backToTopBtn = document.getElementById('backToTop');

        window.addEventListener('scroll', () => {
            if (window.scrollY > 50) navbar.classList.add('scrolled');
            else navbar.classList.remove('scrolled');

            if (window.scrollY > 500) backToTopBtn.classList.add('visible');
            else backToTopBtn.classList.remove('visible');

            revealOnScroll();
        });

        // Scroll reveal
        function revealOnScroll() {
            document.querySelectorAll('[data-reveal]').forEach(el => {
                if (el.getBoundingClientRect().top < window.innerHeight - 100) {
                    el.classList.add('visible');
                }
            });
        }

        // iframe hero scaling
        function scaleHeroIframe() {
            const wrapper = document.getElementById('heroWrapper');
            const iframe = document.getElementById('heroIframe');
            if (!wrapper || !iframe) return;
            const w = wrapper.offsetWidth;
            const h = wrapper.offsetHeight;
            if (w === 0) return;
            const targetW = 1440;
            const scale = w / targetW;
            iframe.style.width = targetW + 'px';
            iframe.style.height = (h / scale) + 'px';
            iframe.style.transform = 'scale(' + scale + ')';
        }

        window.addEventListener('resize', scaleHeroIframe);
        scaleHeroIframe();
        revealOnScroll();
    </script>

</body>
</html>
"@
}

# ── Project data ──────────────────────────────────────────────

$projects = @(
    @{
        slug="fork-fire"; name="Fork & Fire"; category="Food"; tagline="Where Flavor Meets Flame"
        shortDesc="Premium restaurant landing page designed to highlight a bold, fire-inspired dining experience."
        description="Fork & Fire is a premium restaurant landing page designed to highlight a bold, fire-inspired dining experience. The website focuses on rich visuals, elegant typography, and a balanced layout that reflects both passion and professionalism. It showcases signature dishes, chef specials, and the restaurant's unique atmosphere in a way that instantly builds appetite and trust. The design blends modern aesthetics with warmth, making it ideal for upscale cafés, grills, and contemporary restaurants looking to create a strong digital impression."
        problem="Many restaurant websites fail to communicate their brand story and food quality effectively, resulting in low engagement and weak customer interest."
        solution="Fork & Fire presents a visually immersive and brand-driven landing page that highlights food presentation, ambiance, and menu clarity—encouraging users to explore, visit, or place an order."
        features=@("Elegant, fire-inspired visual theme","High-quality food imagery and hero sections","Clear menu highlights and featured dishes","Smooth scrolling and intuitive navigation","Strong branding through typography and colors")
        techStackDetails=@("HTML5 — Semantic and SEO-friendly structure","CSS3 — Custom layouts, transitions, and visual effects","JavaScript (Vanilla JS) — Smooth scrolling and interactive elements","Responsive Design — Fully optimized for mobile, tablet, and desktop","Performance Optimized UI — Fast loading and clean user experience")
        audience="Food lovers, café visitors, restaurant owners, and modern dining brands."
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","Performance Optimized")
        link="https://fork-fire-preview.vercel.app/"
    },
    @{
        slug="veloura-bakery"; name="Veloura Bakery"; category="Food"; tagline="Crafted with Love. Baked to Perfection"
        shortDesc="Soft, elegant bakery landing page designed to showcase handcrafted baked goods."
        description="Veloura Bakery is a soft, elegant bakery landing page designed to showcase handcrafted baked goods in a warm and inviting way. The design emphasizes pastel tones, smooth spacing, and mouth-watering product visuals to create a comforting user experience. From fresh breads to luxury desserts, the layout guides visitors through products effortlessly while highlighting quality, freshness, and craftsmanship. It's built to boost brand trust, product discovery, and customer engagement."
        problem="Many bakery websites feel cluttered or outdated, making premium products look ordinary and reducing customer interest."
        solution="Veloura Bakery delivers a clean, aesthetically pleasing landing page that elevates product presentation and emotionally connects with customers through design and storytelling."
        features=@("Soft, elegant bakery-themed UI","Product-focused sections with clean spacing","Clear highlights for best-selling items","Smooth scrolling and simple navigation","Brand-consistent color palette and typography")
        techStackDetails=@("HTML5 — Well-structured content layout","CSS3 — Smooth animations and refined styling","JavaScript (Vanilla JS) — UI interactions and scrolling effects","Responsive Design — Seamless experience on all devices","User-Centered Layout — Designed for clarity and comfort")
        audience="Bakery customers, dessert lovers, café brands, and small food businesses."
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","User-Centered Layout")
        link="https://veloura-bakery-preview.vercel.app/"
    },
    @{
        slug="cafe-ember"; name="Cafe Ember"; category="Food"; tagline="Warm Moments. Perfect Brews"
        shortDesc="Cozy and modern café landing page built to reflect warmth, comfort, and lifestyle appeal."
        description="Café Ember is a cozy and modern café landing page built to reflect warmth, comfort, and lifestyle appeal. The design uses earthy tones, minimal layouts, and atmospheric imagery to create an inviting digital café experience. It highlights beverages, snacks, and café ambiance while encouraging visitors to relax, explore, and visit in person. The layout focuses on storytelling, mood, and brand personality rather than cluttered content."
        problem="Many café websites lack emotional connection and atmosphere, failing to represent the in-store experience online."
        solution="Café Ember recreates the café's cozy vibe digitally through thoughtful design, smooth navigation, and visually rich sections that engage users instantly."
        features=@("Cozy, lifestyle-focused visual design","Strong hero section with brand messaging","Highlighted drinks and café specials","Smooth scrolling and minimal navigation","Atmosphere-driven color scheme")
        techStackDetails=@("HTML5 — Clean and accessible markup","CSS3 — Custom styling, transitions, and layout control","JavaScript (Vanilla JS) — Interactive UI and smooth effects","Responsive Design — Optimized for every screen size","Brand-First UI — Focused on mood and storytelling")
        audience="Coffee lovers, café visitors, lifestyle brands, and boutique cafés."
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","Brand-First UI")
        link="https://cafe-ember-preview.vercel.app/"
    },
    @{
        slug="zoom-taxi"; name="Zoom Taxi"; category="Transportation"; tagline="Fast. Reliable. On-Demand Mobility"
        shortDesc="Modern transportation platform for fast, reliable ride booking."
        description="Zoom Taxi is a modern transportation platform designed to provide fast, reliable, and user-friendly ride booking experiences. The platform connects passengers with nearby drivers in real time, enabling quick pickups, transparent pricing, and seamless ride management. Built with a clean and intuitive interface, Zoom Taxi focuses on speed, accessibility, and trust. Users can easily book rides, track drivers live, and manage trips without confusion. The landing page is optimized for conversions, clearly highlighting service benefits, coverage, and ease of use."
        problem="Traditional taxi services often suffer from delayed pickups, unclear pricing, poor user experience, and lack of real-time tracking, leading to frustration and distrust among users."
        solution="Zoom Taxi solves these issues by offering real-time ride booking, transparent fare information, and live driver tracking through a streamlined digital experience that prioritizes convenience and reliability."
        features=@("Instant ride booking","Real-time driver tracking","Transparent pricing system","User-friendly booking interface","Mobile-first responsive design")
        techStackDetails=@("HTML5 — Semantic and SEO-friendly structure","CSS3 — Modern layouts with Flexbox & Grid","JavaScript (Vanilla JS) — Interactive UI and smooth user flow","Responsive Design — Optimized for mobile and desktop","Performance Optimized — Fast loading and lightweight assets")
        audience="Urban commuters, travelers, and businesses seeking dependable ride solutions."
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","Performance Optimized")
        link="https://zoom-taxi-preview.vercel.app/"
    },
    @{
        slug="bite-haven"; name="Bite Haven"; category="Food"; tagline="Bold Flavors. Fast Service. Better Experience"
        shortDesc="High-impact fast food restaurant landing page for menus and orders."
        description="Bite Haven is a high-impact fast food restaurant landing page crafted to showcase menu offerings, promotions, and brand personality in a visually engaging way. The platform focuses on appetizing visuals, clear navigation, and strong call-to-action placement to drive online orders and customer engagement. Designed with bold colors and modern typography, Bite Haven creates an instant craving-driven connection with users."
        problem="Many restaurant websites lack visual appeal, clear menus, and strong CTAs, causing visitors to leave without placing an order or visiting the restaurant."
        solution="Bite Haven delivers a visually rich, conversion-focused landing page that highlights food items clearly, guides users effortlessly through the menu, and encourages quick action through prominent CTAs."
        features=@("Visually rich food-focused design","Clear menu categories and sections","Strong call-to-action buttons","Smooth scrolling navigation","Brand-focused color system")
        techStackDetails=@("HTML5 — Clean, structured markup","CSS3 — Custom styling with animations and hover effects","JavaScript (Vanilla JS) — Smooth scrolling and UI interactions","Responsive Design — Optimized for all devices","Conversion Optimized UI — Designed to drive orders and engagement")
        audience="Foodies, hungry customers, restaurant owners."
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","Conversion Optimized UI")
        link="https://bite-haven-preview.vercel.app/"
    },
    @{
        slug="green-yard"; name="Green Yard"; category="Service"; tagline="Professional Outdoor Care Made Simple"
        shortDesc="Professional service landing page for garden maintenance and lawn care."
        description="Green Yard is a professional service landing page designed for garden maintenance, lawn care, and outdoor landscaping businesses. The platform presents services clearly and professionally, building trust with potential customers through clean layouts, service highlights, and strong visual hierarchy. The design emphasizes reliability, expertise, and eco-friendly practices while guiding users toward service inquiries and bookings."
        problem="Many lawn and garden service providers rely on outdated or unclear websites that fail to communicate professionalism, service quality, and trust."
        solution="Green Yard provides a clean, structured, and trustworthy digital experience that clearly explains services, showcases expertise, and encourages users to contact or book services easily."
        features=@("Clear service breakdowns","Trust-focused professional design","Easy contact and inquiry flow","Service-specific sections with visuals","Local business-friendly layout")
        techStackDetails=@("HTML5 — Semantic and accessible structure","CSS3 — Modern layouts using Flexbox & Grid","JavaScript (Vanilla JS) — Interactive elements and smooth UX","Responsive Design — Mobile-first optimization","SEO-Friendly Structure — Built for discoverability")
        audience="Homeowners, property managers, local businesses."
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","SEO-Friendly Structure")
        link="https://green-yard-preview.vercel.app/"
    },
    @{
        slug="neuroai"; name="NeuroAI"; category="SaaS"; tagline="The Future of Intelligence"
        shortDesc="Advanced AI-driven data intelligence for modern enterprises."
        description="NeuroAI is a powerful SaaS platform built to help modern enterprises harness the full potential of artificial intelligence. It enables organizations to analyze complex datasets, automate decision-making, and gain real-time insights through an intuitive and visually rich interface. Designed for scalability and performance, NeuroAI bridges the gap between raw data and actionable intelligence. Its clean dashboards and advanced analytics empower teams to move faster, smarter, and with confidence."
        problem="Enterprises often deal with massive volumes of data that are difficult to process, analyze, and interpret in real time. Traditional analytics tools are slow, complex, and require heavy manual effort."
        solution="NeuroAI transforms raw data into meaningful insights using AI-powered analytics and real-time visualization, allowing businesses to make faster and smarter decisions."
        features=@("Real-time data processing and visualization","AI-driven analytics and predictions","Customizable dashboards","Team collaboration tools","Enterprise-level security")
        techStackDetails=@("HTML5 — Semantic, SEO-optimized structure","CSS3 — Modern layouts using Flexbox & Grid","JavaScript (Vanilla JS) — Interactive dashboards & UI behavior","Responsive Design — Optimized for all screen sizes","Performance Optimized — Lightweight and fast-loading")
        audience="Data Scientists, CTOs, Product Teams, Enterprise Decision Makers"
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","Performance Optimized")
        link="https://neuroai-preview.vercel.app/"
    },
    @{
        slug="thememint"; name="ThemeMint"; category="SaaS"; tagline="Build, Launch, Scale Faster"
        shortDesc="A comprehensive toolkit for rapid UI development."
        description="ThemeMint is a modern SaaS-focused landing page designed to help startups and digital products present their value with clarity and confidence. It combines bold visuals with conversion-optimized layouts to communicate features, benefits, and pricing effectively. The design is clean, flexible, and built to adapt to various SaaS use cases. ThemeMint focuses on storytelling, guiding users from problem awareness to solution adoption."
        problem="Many SaaS startups struggle to explain their product clearly and fail to convert visitors into users."
        solution="ThemeMint provides a clear, structured layout that communicates value instantly and encourages user action."
        features=@("Conversion-focused hero section","Feature and benefit breakdown","Pricing and CTA sections","Responsive layout","Clean modern UI")
        techStackDetails=@("HTML5 — Clean and scalable page structure","CSS3 — Conversion-focused layout and styling","JavaScript (Vanilla JS) — Smooth interactions and navigation","Responsive Design — Mobile-first approach","Clean Code Architecture — Easy to customize and extend")
        audience="SaaS Startups, Indie Founders, Product Launch Teams"
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","Clean Code Architecture")
        link="https://theme-mint-preview.vercel.app/"
    },
    @{
        slug="skill-forge-academy"; name="Skill Forge Academy"; category="Education"; tagline="Learn Skills That Matter"
        shortDesc="Online learning platform for creative professionals."
        description="Skill Forge Academy is an educational landing page crafted to promote online courses, training programs, and learning platforms. It focuses on clarity, trust, and engagement to encourage learners to enroll. The layout emphasizes course value, instructor credibility, and learning outcomes. With structured sections and smooth flow, it helps users understand the learning journey."
        problem="Online learners often feel overwhelmed by unclear course structures and lack of trust."
        solution="Skill Forge Academy presents courses in a clear, engaging, and confidence-building format."
        features=@("Course highlights","Instructor profiles","Learning outcomes","Enrollment CTA","Mobile-friendly design")
        techStackDetails=@("HTML5 — Structured course and content sections","CSS3 — Readable typography and layout system","JavaScript (Vanilla JS) — Interactive sections and smooth scroll","Responsive Design — Optimized for learners on all devices","Accessibility-Friendly Markup — Clear UI and spacing")
        audience="Students, Professionals, Online Learners"
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","Accessibility-Friendly")
        link="https://skill-forge-academy-preview.vercel.app/"
    },
    @{
        slug="shop-ease"; name="Shop Ease"; category="E-commerce"; tagline="Simple Shopping, Smarter Sales"
        shortDesc="Modern, fast, and conversion-optimized e-commerce."
        description="Shop Ease is a modern e-commerce landing page designed to showcase products with clarity and style. It focuses on clean layouts, strong visuals, and smooth user experience to drive conversions. The design highlights featured products, benefits, and trust signals. It is optimized for fast browsing and easy purchasing decisions. Ideal for startups and small businesses entering online retail."
        problem="Many online stores lose customers due to cluttered layouts and confusing navigation."
        solution="Shop Ease simplifies product presentation and purchasing flow to increase conversions."
        features=@("Product showcase sections","Promotional banners","Clear CTAs","Responsive grid layout","Trust indicators")
        techStackDetails=@("HTML5 — Product-focused semantic structure","CSS3 — Grid-based product layouts","JavaScript (Vanilla JS) — UI interactions and CTA behavior","Responsive Design — Seamless shopping experience on mobile","Optimized UI Performance — Fast rendering and clean visuals")
        audience="Online Shoppers, Small Businesses, E-commerce Brands"
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","Optimized UI Performance")
        link="https://shop-ease-e-commerce-preview.vercel.app/"
    },
    @{
        slug="next-gen-agency"; name="Next Gen Agency"; category="Agency"; tagline="Creative Solutions for Modern Brands"
        shortDesc="Immersive agency portfolio with bold creative direction."
        description="Next Gen Agency is a bold, creative landing page built for digital agencies and studios. It highlights services, expertise, and past work in a visually engaging way. The layout builds credibility and positions the agency as a premium service provider. Designed to attract clients and generate leads, it balances creativity with clarity."
        problem="Agencies often struggle to stand out in a crowded digital market."
        solution="Next Gen Agency presents services and value in a confident, professional format."
        features=@("Service highlights","Portfolio showcase","Client-focused CTAs","Modern animations","Strong branding")
        techStackDetails=@("HTML5 — Professional agency layout structure","CSS3 — Creative animations and modern styling","JavaScript (Vanilla JS) — Interactive UI and hover effects","Responsive Design — Fully adaptive agency showcase","Scalable Styling System — Easy branding customization")
        audience="Startups, Businesses, Brands, Founders"
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","Scalable Styling")
        link="https://next-gen-agency-preview.vercel.app/"
    },
    @{
        slug="care-plus"; name="Care Plus"; category="Medical"; tagline="Healthcare You Can Trust"
        shortDesc="Streamlined healthcare management for modern clinics."
        description="Care Plus is a healthcare landing page designed to communicate trust, clarity, and professionalism. It presents medical services in a calm and accessible way. The design focuses on patient confidence, service transparency, and easy navigation. Ideal for clinics, hospitals, and health service providers."
        problem="Patients often feel uncertain due to unclear medical information online."
        solution="Care Plus delivers clear, reassuring, and structured healthcare information."
        features=@("Service listings","Appointment CTA","Trust-focused layout","Clean medical UI","Responsive design")
        techStackDetails=@("HTML5 — Trust-focused and structured markup","CSS3 — Clean medical UI with calm visuals","JavaScript (Vanilla JS) — Interactive navigation and CTAs","Responsive Design — Optimized for patients on all devices","Accessibility-Oriented Design — Clear contrast and readability")
        audience="Patients, Clinics, Healthcare Providers"
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","Accessibility-Oriented")
        link="https://care-plus-medical-preview.vercel.app/"
    },
    @{
        slug="lead-boost"; name="Lead Boost"; category="Marketing"; tagline="Turn Visitors into Customers"
        shortDesc="Conversion-focused landing page for marketing teams."
        description="Lead Boost is a marketing-focused landing page built to capture and convert leads. It uses persuasive content, strong CTAs, and conversion-driven layouts. The design emphasizes value propositions and results. Perfect for marketers and growth-focused businesses."
        problem="Businesses struggle to convert traffic into qualified leads."
        solution="Lead Boost optimizes messaging and layout to maximize conversions."
        features=@("Lead capture forms","Conversion-focused sections","Strong CTAs","Analytics-ready structure","Clean UI")
        techStackDetails=@("HTML5 — Conversion-driven layout structure","CSS3 — Marketing-focused design and spacing","JavaScript (Vanilla JS) — Lead forms and CTA interactions","Responsive Design — Mobile-optimized conversion flow","Performance Optimization — Lightweight and fast")
        audience="Marketers, Agencies, Business Owners"
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","Performance Optimization")
        link="https://lead-boost-preview.vercel.app/"
    },
    @{
        slug="launch-pad"; name="Launch Pad"; category="SaaS"; tagline="Launch Smarter. Grow Faster."
        shortDesc="Growth tools and validation for early-stage startups."
        description="Launch Pad is a startup-focused landing page designed to help founders and product teams launch their ideas with clarity and confidence. It provides a structured storytelling flow that introduces the product, highlights its value, and drives early adoption. The design emphasizes speed, simplicity, and conversion, making it ideal for MVPs and early-stage products."
        problem="Many startups struggle to clearly communicate their product vision and fail to convert early visitors into users or investors."
        solution="Launch Pad offers a clear, launch-ready structure that presents the product story, benefits, and CTAs in a compelling and conversion-driven format."
        features=@("Startup-focused hero section","Clear product value proposition","Feature highlights with benefits","Strong call-to-action placement","Fully responsive launch layout")
        techStackDetails=@("HTML5 — Launch-ready semantic structure","CSS3 — Modern startup layouts using Grid & Flexbox","JavaScript (Vanilla JS) — Interactive sections and smooth transitions","Responsive Design — Perfect for MVP and early-stage products","Clean & Modular Code — Easy iteration and scaling")
        audience="Startup Founders, Indie Hackers, Product Managers, Early-Stage Teams"
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","Clean & Modular Code")
        link="https://launch-pad-preview.vercel.app/"
    },
    @{
        slug="future-tech-summit"; name="Future Tech Summit"; category="Marketing"; tagline="Where Innovation Meets the Future"
        shortDesc="Global tech conference landing page with full event info."
        description="Future Tech Summit is a modern event landing page crafted for technology conferences, summits, and innovation-driven events. It is designed to generate excitement, communicate event value, and drive registrations. The layout highlights speakers, agenda, and key themes in a visually engaging manner. With a strong focus on credibility and anticipation, it positions the event as a must-attend experience."
        problem="Event organizers often struggle to capture attention and clearly communicate the value of attending their events."
        solution="Future Tech Summit presents event details, speakers, and highlights in a structured, visually appealing format that drives registrations."
        features=@("Speaker and agenda sections","Event highlights and themes","Registration-focused CTAs","Countdown or timeline layout","Engaging visual storytelling")
        techStackDetails=@("HTML5 — Structured event sections and content","CSS3 — Visual hierarchy and engaging layouts","JavaScript (Vanilla JS) — Countdown timers and dynamic UI","Responsive Design — Event-ready across all devices","Accessible & Readable UI — Clear event information flow")
        audience="Tech Professionals, Entrepreneurs, Developers, Event Attendees"
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","Accessible & Readable UI")
        link="https://future-tech-summit-preview.vercel.app/"
    },
    @{
        slug="thememint-launch-kit"; name="ThemeMint Launch Kit"; category="SaaS"; tagline="Everything You Need to Launch Faster"
        shortDesc="Comprehensive toolkit for successful product launches."
        description="ThemeMint Launch Kit is a product-focused landing page designed to showcase a complete launch-ready UI and design kit. It communicates value through clarity, structure, and visual consistency. The page highlights what's included, how it helps users, and why it saves time and effort. Built with creators and developers in mind, it positions the kit as a practical and premium solution."
        problem="Creators and developers often waste time building launch pages and UI from scratch, slowing down product launches."
        solution="ThemeMint Launch Kit provides a ready-to-use, professionally designed system that accelerates product launches and ensures consistency."
        features=@("Pre-built launch sections","Modular and reusable components","Clean, modern UI design","Easy customization","Launch-ready structure")
        techStackDetails=@("HTML5 — Modular, reusable layout components","CSS3 — Scalable design system and styling","JavaScript (Vanilla JS) — UI interactions and component behavior","Responsive Design — Framework-free adaptive layout","Maintainable Codebase — Creator-friendly customization")
        audience="Designers, Developers, Startup Teams, Product Creators"
        tech=@("HTML5","CSS3","JavaScript","Responsive Design","Maintainable Codebase")
        link="https://theme-mint-launch-kit-preview.vercel.app/"
    }
)

# Generate all pages
foreach ($p in $projects) {
    $html = Get-DetailPage -p $p
    $filePath = Join-Path $basePath "$($p.slug).html"
    [System.IO.File]::WriteAllText($filePath, $html, [System.Text.UTF8Encoding]::new($false))
    Write-Host "Created: $filePath"
}

Write-Host "`nAll $($projects.Count) template pages generated successfully!"
