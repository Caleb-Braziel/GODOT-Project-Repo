# Godot Projects

This repository contains a collection of game and application projects built in the Godot Engine. The projects range from tile-based word games to educational study tools, and reflect ongoing development across gameplay systems, UI design, and Python-driven question generation.

---

## Project Overview

### 🔤 Infinite Tile Word Game

A Scrabble-inspired word game built around a relaxed tile constraint system. Rather than limiting players to a fixed set of physical tiles, the game checks whether a word can be formed using only the letters available in the current tile pool — any letter present in the pool can be used as many times as needed.

**How it works:** If the current tile set is `{a, b, c, d, e, f, g}`, a word like *bedded* is valid because every letter in the word appears somewhere in the pool. The game does not track individual tile counts.

**Current status:** Core word validation logic is in progress. Future development will introduce a full Scrabble-style board, scoring system, and multiplayer support.

**Planned features:**
- Board layout with standard Scrabble tile placement
- Score tracking and word validation against a dictionary
- UI polish and responsive tile placement

---

### 📐 FE Exam Study App

A Godot-based study application designed to help prepare for the Mechanical Engineering Fundamentals of Engineering (FE) exam. The app integrates Python scripts that procedurally generate FE-style practice questions, bringing them into an interactive interface for review and self-testing.

**Current status:** The economics section is partially implemented, with question generation logic actively being refined. Heat and mass transfer question generation scripts are written and will be integrated once the economics module is stable.

**Development roadmap:**
- Finalize logic for economics question generation and display
- Implement the heat and mass transfer question module
- Expand to additional FE exam topic areas over time

**Tech stack:**
- Godot Engine (UI, app flow, question display)
- Python (FE-style question generation scripts)

---

## Design Focus

Across both projects, the primary development goals include:

- Clean separation between game logic and UI layer
- Modular question and game systems that are easy to extend
- Progressive feature implementation — core mechanics first, polish second
- Integration of external scripts (Python) with Godot's runtime where applicable

---

## Tools & Technologies

- **Engine:** Godot Engine (GDScript)
- **Scripting:** Python (question generation)
- **Domains:** Puzzle/word games, educational tooling, exam preparation
- **Target exam:** NCEES Mechanical FE Exam

---

## Notes

Both projects are under active development. Features and structure may change significantly as development progresses.

---

## Author

**Caleb Braziel**  
Mechanical Engineering · CAD · Game Development · PCB Design
