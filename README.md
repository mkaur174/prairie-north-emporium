cat << 'EOF' > README.md
# Prairie North Board Game & Hobby Emporium — WEBD-3011 E-Commerce Project

## Completed Features Summary (52% Total — 18 Features, All 4 Starred Features Included)

- **1.1** — Gain access to an admin dashboard by providing a username and password. (2%)
- **1.2** — Add, edit or delete product listings by way of an admin dashboard. ✩ (2%)
- **1.4** — Edit the content of the website's contact and about page. (2%)
- **1.5** — Create and maintain a list of product categories and assign categories to new or existing products. (2%)
- **1.6** — Seed your product database with products and associated categories. (2%)
- **2.1** — Navigate through the available products by way of a front page. ✩ (2%)
- **2.2** — Navigate through the available products by category. (2%)
- **2.3** — View the details of any of the available products on their own product page. ✩ (2%)
- **2.4** — Two or more of the following. Filter the products to see only the products that are: on sale, new, recently updated. (2%)
- **2.5** — Products listing are paginated. (There's a gem for that.) (2%)
- **2.6** — Search through the available products using a keyword search by category. (4%)
- **3.1.1** — Add various products to a shopping cart saved in session. (4%)
- **3.1.2** — Edit quantity of items in shopping cart and remove items from cart. Be able to edit quantity on its own after adding to cart. (4%)
- **3.1.3** — Complete a checkout process after filling their shopping cart. (8%)
- **3.2.1** — List all past orders along with the order details. (Can also be implemented for all customers from the admin dashboard.) (4%)
- **4.1.4** — Make use of Rails "View Partials" to DRY up your views. (2%)
- **4.2.1** — Use Rails validations in all of your models (except join models) to ensure that data submitted to the site by administrator and customers is present and correctly formatted. (2%)
- **5.1** — Use git and github to keep your source under control with the ability to push from master to origin. 32 commits and three branch minimum. ✩ (4%)

**Total:** 52% | **Starred Features Completed:** 4 / 4 (`1.2`, `2.1`, `2.3`, `5.1`) | **Deductions:** 0%

---

## Feature-by-Feature Implementation & Demonstration Guide

### 1. Product Administration

#### **1.1 — Admin Dashboard Login (2%)**
- **How We Built It:** Installed the `activeadmin` and `devise` gems (`rails generate active_admin:install`), creating the `AdminUser` model with encrypted password authentication and a seeded admin account (`admin@prairienorth.ca` / `password123`).
- **How to Demonstrate:** Navigate to `http://127.0.0.1:3000/admin`, log out if already signed in, and log in using `admin@prairienorth.ca` and `password123`.

#### **1.2 — Add, Edit, or Delete Product Listings via Admin Dashboard ✩ (2%)**
- **How We Built It:** Registered `Product` in `app/admin/products.rb` with `permit_params :title, :description, :price, :stock_quantity, :category_id`, custom index columns, and a form supporting category assignment, pricing, stock, and descriptions (no lorem ipsum).
- **How to Demonstrate:** Go to **Admin -> Products** (`/admin/products`). Create a new board game product, edit an existing product's price or description (this also sets up Feature `2.4` Recently Updated), and delete a test product.

#### **1.4 — Edit Contact and About Page Content (2%)**
- **How We Built It:** Created a `Page` model (`title`, `slug`, `content`) seeded with `"about"` and `"contact"` records, registered `app/admin/pages.rb` restricted to `actions :index, :show, :edit, :update` (no scaffolded CRUD), and mapped `/about` and `/contact` routes to `PagesController#show`.
- **How to Demonstrate:** Open `/about` and `/contact` on the storefront, then go to **Admin -> Pages** (`/admin/pages`), edit the text on one of the pages, save it, and refresh the public page to show the updated content.

#### **1.5 — Create and Maintain Categories & Assign to Products (2%)**
- **How We Built It:** Created the `Category` model (`has_many :products`) and `Product` association (`belongs_to :category`), and registered `app/admin/categories.rb` with `permit_params :name, :description`.
- **How to Demonstrate:** Open **Admin -> Categories** (`/admin/categories`), create or edit a category, and assign a product to that category inside **Admin -> Products**.

#### **1.6 — Seed Product Database with Products & Categories (2%)**
- **How We Built It:** Wrote `db/seeds.rb` to populate 4 distinct tabletop categories (*Board Games*, *Miniatures*, *Trading Cards*, *Artisan Puzzles*) with 104 authentic products (26 per category) and all 13 Canadian provinces/territories with their GST/PST/HST tax rates.
- **How to Demonstrate:** Show `db/seeds.rb` in VS Code and point out the 104 seeded products across 4 categories on the storefront (`104 products found`).

---

### 2. Product Display

#### **2.1 — Navigate Available Products via Front Page ✩ (2%)**
- **How We Built It:** Configured `root "products#index"` in `config/routes.rb` and queried `Product.includes(:category).order(:title)` in `ProductsController#index`, rendering products in a responsive Bootstrap card grid.
- **How to Demonstrate:** Visit `http://127.0.0.1:3000/` and scroll through the main product catalog.

#### **2.2 — Navigate Available Products by Category (2%)**
- **How We Built It:** Built a dedicated `CategoriesController#show` route (`/categories/:id`) and rendered dynamic category links in `app/views/shared/_navbar.html.erb` separate from the search form.
- **How to Demonstrate:** Click any category link in the top navigation bar (*Artisan Puzzles*, *Board Games*, *Miniatures*, *Trading Cards*) to view only that category's products.

#### **2.3 — View Product Details on Individual Product Page ✩ (2%)**
- **How We Built It:** Implemented `ProductsController#show` (`/products/:id`) and `app/views/products/show.html.erb` displaying the product title, category badge, full description, price, available stock quantity, and an **Add to Cart** button.
- **How to Demonstrate:** Click any product title or **View Details** button on a product card to open its individual product page.

#### **2.4 — Filter Products by New and Recently Updated (2%)**
- **How We Built It:** Added `scope :new_arrivals` (`created_at >= 3.days.ago`) and `scope :recently_updated` (`updated_at >= 3.days.ago AND updated_at > created_at`) in `app/models/product.rb`, wired to `params[:filter]` in `ProductsController#index` with filter buttons on the front page.
- **How to Demonstrate:** Click **New Arrivals** and **Recently Updated** buttons above the search bar on the front page to filter the catalog dynamically.

#### **2.5 — Paginated Product Listings (2%)**
- **How We Built It:** Added the `kaminari` gem, chained `.page(params[:page]).per(12)` in `ProductsController#index` and `CategoriesController#show`, and rendered `<%= paginate @products %>` with Bootstrap pagination views.
- **How to Demonstrate:** Scroll to the bottom of the front page (`104 products found`, 12 per page) and click page numbers (`2`, `3`, `Next`) to navigate across pages.

#### **2.6 — Keyword Search by Category Dropdown (4%)**
- **How We Built It:** Built a search form in `app/views/products/index.html.erb` with a keyword text input and a category `<select>` dropdown (`All Categories` or a specific category), querying `WHERE title LIKE ? OR description LIKE ?` combined with `category_id` filtering in `ProductsController#index`.
- **How to Demonstrate:** Enter a keyword (e.g., `"Dragon"` or `"Winnipeg"`), test searching across **All Categories**, and then restrict the same keyword to a specific category from the dropdown.

---

### 3. Product Orders

#### **3.1.1 — Add Products to Session-Based Shopping Cart (4%)**
- **How We Built It:** Initialized `session[:cart] ||= {}` in `ApplicationController` (`{ product_id => quantity }`) and implemented `CartsController#add` (`POST /cart/add/:product_id`) with a live cart item counter in the navbar.
- **How to Demonstrate:** Click **Add to Cart** on multiple different products and show the navbar button updating to `Cart (2)`, `Cart (3)`, etc., then click **Cart** to view the session items.

#### **3.1.2 — Edit Cart Item Quantity & Independent Remove Button (4%)**
- **How We Built It:** Built `app/views/carts/show.html.erb` with a dedicated quantity number field + **Update** form (`PATCH /cart/update/:product_id`) and a completely separate **Remove** button (`DELETE /cart/remove/:product_id`) handled by `CartsController#update` and `CartsController#remove`.
- **How to Demonstrate:** On `/cart`, change an item's quantity in the number box and click **Update** to recalculate the line total and subtotal; then click the separate **Remove** button on another item to delete it independently.

#### **3.1.3 — Checkout Process with Provincial Tax Invoice (8%)**
- **How We Built It:** Implemented `OrdersController#new` and `#create` collecting customer contact and shipping details including a `Province` dropdown (`Customer belongs_to :province`). On submission, the controller looks up the selected province's `gst`, `pst`, and `hst` rates, calculates itemized taxes and `total_amount`, persists the `Customer`, `Order`, and `OrderItem` records (locking in unit prices), clears `session[:cart]`, and renders the itemized tax invoice on `OrdersController#show`.
- **How to Demonstrate:** Click **Proceed to Checkout**, fill out customer details, select **Manitoba** (5% GST + 7% PST) or **Ontario** (13% HST), submit the order, and walk through the generated tax invoice.

#### **3.2.1 — List All Past Orders with Customer, Products, Taxes & Grand Total in Admin (4%)**
- **How We Built It:** Customized `app/admin/orders.rb` using `includes(customer: :province, order_items: :product)` so the `/admin/orders` index table displays every order alongside the customer's name/email/province, a bulleted list of ordered products with quantities and unit prices, the GST/PST/HST tax breakdown, and the grand total on a single screen without navigating to other pages.
- **How to Demonstrate:** Open **Admin -> Orders** (`/admin/orders`) and show the newly placed order with its customer info, product list, taxes, and grand total all visible on the main table.

---

### 4. Layout and Application Design

#### **4.1.4 — Rails View Partials to DRY Up Views (2%)**
- **How We Built It:** Extracted reusable UI components into `app/views/shared/_navbar.html.erb`, `app/views/shared/_flash.html.erb`, and `app/views/products/_product_card.html.erb`, rendering them across `layouts/application.html.erb`, `products/index.html.erb`, and `categories/show.html.erb`.
- **How to Demonstrate:** Open `app/views/layouts/application.html.erb`, `app/views/products/index.html.erb`, and `app/views/categories/show.html.erb` in VS Code to show the `render` calls to the three partials.

#### **4.2.1 — Rails Model Validations on All Non-Join Models (2%)**
- **How We Built It:** Added presence, uniqueness, numericality, and regex format validations across all non-join models (`Province`, `Category`, `Product`, `Customer`, `Order`, `Page`), leaving only the join model (`OrderItem`) without validations.
- **How to Demonstrate:** Open `app/models/customer.rb` and `app/models/product.rb` in VS Code, and submit invalid data on `/orders/new` (e.g., an invalid email or postal code) to trigger the validation error alerts.

---

### 5. Source Control, Deployment, Testing, and Dependency Management

#### **5.1 — Git & GitHub Version Control (32+ Commits, 3+ Branches) ✩ (4%)**
- **How We Built It:** Initialized Git from day one (`master` pushed to `origin` on GitHub), developed features across separate feature branches (`feature/database-models`, `feature/admin-and-seeds`, `feature/storefront-and-search`, `feature/cart-and-checkout`, `feature/pagination`, `feature/product-filters`, `feature/admin-pages-and-orders`), and merged them into `master` with 35+ descriptive commits.
- **How to Demonstrate:** Open your GitHub repository (`https://github.com/mkaur174/prairie-north-emporium`) or run `git log --oneline` and `git branch -a` in the terminal to show the commit count (32+) and merged branches.

EOF
git add README.md
git commit -m "Add complete README with completed feature summary and demonstration guide"
git push origin master