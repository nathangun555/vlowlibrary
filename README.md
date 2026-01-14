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

File:
- CatalogTabView.swift

Features:
- List semua buku
- Menampilkan Judul, Author, dan Availabality Status

----------------------------------
➕ BORROW
----------------------------------

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

Features:
- Sama seperti Staff Catalog
- Read-only
- Tidak bisa borrow

----------------------------------
📋 MY LOANS
----------------------------------

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

## 🔗 DATABASE & SUPPORTING FILES
https://drive.google.com/drive/folders/1ERF8MyqQQYakUR64mDp-OVJ61I6aFc-Y?usp=share_link
