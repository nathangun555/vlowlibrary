# 📚 VlowLibrary — Library Management System

**iOS Library Management Application** built with **SwiftUI + Supabase**, developed to fulfill **Programmer Certification (KKNI)** requirements.

================================================================================

## 📋 PROJECT OVERVIEW

| Detail | Information |
|------|------------|
| Certification | PEMROGRAM — FR.IA.02 (IMT.01.15/SSK/LSP/X/2021) |
| Developer | Nathan Gunawan |
| Platform | iOS |
| Tech Stack | SwiftUI, Supabase (PostgreSQL) |
| Architecture | MVVM |
| Status | Production Ready |

================================================================================

## 🎯 USER FLOW & FEATURES

1. LOGIN

<img width="348" height="737" alt="Screenshot 2026-01-14 at 22 04 14" src="https://github.com/user-attachments/assets/11869633-0957-4b64-81cc-5f1b63b3eaf8" />

File:
- LoginView.swift

UI Flow:
- Username Input
- Login Button

Logic:
SELECT * FROM users WHERE username = ?

Jika sukses:
- Simpan currentUser
- Simpan role (staff / member)
- Redirect ke dashboard sesuai role

Jika gagal:
- Tampilkan error message: "Username tidak ditemukan"

Test Credentials:
- Staff  : nathan.staff
- Member : nathan.member
  
2. STAFF DASHBOARD (3 TABS)

Tabs:
- 📚 Catalog
- ➕ Borrow
- 📋 Loans

----------------------------------
📚 CATALOG (STAFF)
----------------------------------

<img width="331" height="741" alt="Screenshot 2026-01-14 at 22 06 08" src="https://github.com/user-attachments/assets/10deff83-e06d-4a56-bdef-fd3b9931f94e" />

File:
- CatalogTabView.swift

Features:
- List semua buku
- Menampilkan Judul, Author, dan Availabality Status

----------------------------------
➕ BORROW
----------------------------------

<img width="327" height="742" alt="Screenshot 2026-01-14 at 22 06 18" src="https://github.com/user-attachments/assets/9748039c-c379-4ae2-ad46-c46691850a00" />


File:
- BorrowTabView.swift

Flow:
1. Pilih Member
2. Pilih Buku
3. Pilih Tanggal Pinjam
4. Submit

Auto Logic:
- due_date = loan_date + 7 hari

Result:
- Data tersimpan ke table Loans

----------------------------------
📋 LOANS
----------------------------------

<img width="331" height="748" alt="Screenshot 2026-01-14 at 22 06 27" src="https://github.com/user-attachments/assets/3c4727aa-0ca5-4ea9-82dc-fae4ff13616f" />


File:
- LoansTabView.swift

Features:
- List semua loan aktif (returned = false)
- Highlight overdue (warna merah jika lewat due_date)
- Action:
  - Button "Kembalikan"
    - returned = true
    - return_date = NOW()
    - 
3. MEMBER DASHBOARD (2 TABS)

Tabs:
- 📚 Catalog
- 📋 My Loans

----------------------------------
📚 CATALOG (MEMBER)
----------------------------------

<img width="331" height="749" alt="Screenshot 2026-01-14 at 22 06 42" src="https://github.com/user-attachments/assets/b5085e47-4ff5-4af9-92fa-e905f30082b4" />

Features:
- Sama seperti Staff Catalog
- Read-only
- Tidak bisa borrow

----------------------------------
📋 MY LOANS
----------------------------------

<img width="334" height="744" alt="Screenshot 2026-01-14 at 22 06 50" src="https://github.com/user-attachments/assets/b043f20c-1d0d-4eb7-b250-de4b2ce4d42e" />


Logic:
- WHERE user_id = currentUser.id

Features:
- Hanya tampilkan loans milik user login
- Tidak ada return button
- Tidak ada edit action

================================================================================

## 📊 CERTIFICATION COMPLIANCE MATRIX

| Step Group | Requirement | Status | Evidence |
|-----------|------------|--------|---------|
| 1–3 | UML / Methodology | MVVM | All files |
| 4–11 | Coding Standards | Swift Best Practices | ViewModels |
| 12–16 | OOP Classes | Implemented | Models |
| 17–19 | Library Reuse | Supabase SDK | SupabaseService.swift |
| 20–23 | Database CRUD | Full Async Ops | DatabaseQueries.swift |
| 24–27 | Documentation | Complete | This README |
| 28–30 | Error Handling | try-catch | ViewModels |
| 31–35 | Unit Testing | XCTest | LoanTests.swift |

================================================================================

## 👤 AUTHOR
Nathan Gunawan

================================================================================

## 📅 ASSESSMENT STATUS
Assessment Complete — January 11, 2026

================================================================================

## 🔗 DATABASE & UNIT TESTING DOCUMENTATION
https://drive.google.com/drive/folders/1ERF8MyqQQYakUR64mDp-OVJ61I6aFc-Y?usp=share_link
