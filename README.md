# NoMorePaywalls
<div align="center">
  <h1>NoMorePaywalls</h1>
  <p>🍏 A jailbreak tweak for Apple News — no paywalls, all articles visible.</p>
</div>

## 📌 What It Is

**NoMorePaywalls** removes News+ paywall barriers in Apple News on jailbroken iOS devices.  
Built for people who want full access to stories without subscription walls.

⚠️ *Requires a jailbroken iOS device and tweak injection support (e.g., Substitute / libhooker).*  

---

## 🔧 Features

- Removes Apple News+ paywalls
- Works on iOS 10 → 18 (where jailbreak exists)
- Minimal footprint — no UI, just behavior hook

---

## 🛠️ How To Build

```sh
git clone https://github.com/Tweaker177/NoMorePaywalls.git
cd NoMorePaywalls
# customize target (rootless / rootful)
make package
```
Notes
	•	Configure rootless vs rootful in the Makefile if needed
	•	Built using Theos
	•	Targets Apple News private frameworks

⸻

Installation

Install the generated .deb using your preferred package manager:
	•	Sileo
	•	Zebra
	•	Cydia

Or manually via:
```sh
dpkg -i NoMorePaywalls*.deb
```
Respring after installation.

⸻

How It Works 

Apple News performs multiple internal checks to determine whether content should be restricted to News+ subscribers.

This tweak hooks those decision points and neutralizes the gating logic, allowing full article rendering without modifying UI state or network responses.

Details are intentionally kept high-level.

⸻


Legal / Disclaimer

This project is provided for research and educational purposes only.

You are responsible for how you use it.

⸻

License

MIT
