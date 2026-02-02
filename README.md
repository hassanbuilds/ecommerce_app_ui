
<div align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/State_Management-Provider-red?style=for-the-badge" />
</div>

<h1 align="center">🛒 E-Commerce Pro | High-Fidelity Logic</h1>

<p align="center">
  <b>Developed by <a href="https://github.com/hassanbuilds">HassanBuilds</a></b><br>
  <i>A sophisticated technical showcase focusing on Transactional Logic and Modular State Architecture.</i>
</p>

---

## 🌟 Key Features

* <b>Global Cart Engine</b>: Centralized state for adding, removing, and calculating totals across the app. 
* <b>Product Discovery</b>: Dynamic rendering of catalogs using structured, type-safe data models.
* <b>Reactive UI</b>: Real-time interface updates for "Liked" items and cart counts without manual refreshes.
* <b>Clean Folder Architecture</b>: Organized by technical responsibility to ensure scalability.

---

## 🏗 The Architecture

This project follows a <b>Service-Oriented Approach</b> to decouple business logic from the UI layer:

<table>
  <tr>
    <td><b>📂 lib/models/</b></td>
    <td>Defines <code>ProductModel</code> with factory constructors for data integrity.</td>
  </tr>
  <tr>
    <td><b>📂 lib/screens/</b></td>
    <td>High-fidelity modules: <code>CartScreen</code>, <code>ProductScreen</code>, and <code>LikeItems</code>.</td>
  </tr>
  <tr>
    <td><b>📂 lib/services/</b></td>
    <td>Mock data layer (<code>fake_dummy_data.dart</code>) simulating server responses.</td>
  </tr>
  <tr>
    <td><b>📂 lib/main.dart</b></td>
    <td>The centralized navigation hub managing the app-wide tab controller.</td>
  </tr>
</table>



---

## 📝 Technical Deep-Dive

In this project, I prioritized <b>Backend-Ready</b> code. By moving logic out of the widgets and into services:

1.  <b>Efficiency</b>: Only the specific widgets listening to the Cart state rebuild when an item is added.
2.  <b>Readability</b>: Logic is separated from the UI, making the codebase professional and easy to debug.
3.  <b>Scalability</b>: This structure allows for an immediate switch to a live REST API or Firebase.

---

## 🚀 Installation

```bash
# Clone the repository
git clone [https://github.com/hassanbuilds/ecommerce-logic-module.git](https://github.com/hassanbuilds/ecommerce-logic-module.git)

# Install dependencies
flutter pub get

# Run the app
flutter run
