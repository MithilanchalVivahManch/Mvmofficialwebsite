
# 🌸 मिथिलांचल विवाह मंच — Jeevansathi

**मिथिलांचल विवाह मंच** मैथिल युवक-युवतियों के लिए एक आधुनिक विवाह परिचय मंच है। इसका उद्देश्य योग्य वर-वधू और परिवारों को एक-दूसरे से जोड़ना है।

## 💍 वेबसाइट की मुख्य सुविधाएँ

- मैथिल समाज के लिए अलग-अलग समुदाय:
  - ब्राह्मण
  - राजपूत
  - भूमिहार
  - कायस्थ
- वर एवं वधू की प्रोफाइल
- उम्र, जिला, गोत्र, शिक्षा और पेशा के आधार पर खोज
- सरकारी एवं निजी नौकरी के विकल्प
- विवाह योग्य युवक-युवतियों का परिचय
- बायोडाटा जमा करने की सुविधा
- Admin द्वारा प्रोफाइल की जाँच एवं स्वीकृति
- आधुनिक भारतीय विवाह थीम और मैथिली संस्कृति से प्रेरित डिजाइन

## 🔒 गोपनीयता और सुरक्षा

- सामान्य सदस्यों को मोबाइल नंबर नहीं दिखाया जाता।
- सामान्य सदस्यों को वास्तविक प्रोफाइल फोटो नहीं दिखाई जाती।
- मोबाइल नंबर और फोटो निजी रूप से सुरक्षित रखे जाते हैं।
- बायोडाटा प्रकाशित करने से पहले Admin द्वारा जाँच की जाती है।
- निजी जानकारी परिवार की अनुमति के बिना साझा नहीं की जानी चाहिए।
- परिवार सहयोग स्वैच्छिक है; यह अनिवार्य सदस्यता नहीं है।

## 🛠️ तकनीकी जानकारी

- Frontend: HTML, CSS और JavaScript
- Hosting: GitHub Pages
- Database और Authentication: Supabase
- Private Photo Storage: Supabase Storage

## ⚙️ वेबसाइट सेटअप

1. GitHub Repository में `index.html` अपलोड करें।
2. `wedding-couple.png` को मुख्य फोल्डर में रखें।
3. `logo.png` को मुख्य फोल्डर में रखें।
4. `supabase` नाम का फोल्डर बनाएँ।
5. उसके अंदर `schema.sql` अपलोड करें।
6. Supabase के SQL Editor में `schema.sql` चलाएँ।
7. `index.html` में Supabase Project URL और Publishable Key सेट करें।
8. GitHub Pages को `main` Branch के Root Folder से Publish करें।

## 🔑 Admin Setup

Supabase में अपना अकाउंट बनाने के बाद Auth User UUID प्राप्त करें।

फिर SQL Editor में यह कमांड चलाएँ:

```sql
insert into public.admins(user_id)
values ('YOUR_AUTH_USER_UUID');
```

`YOUR_AUTH_USER_UUID` की जगह अपना वास्तविक Auth UUID डालें।

**ध्यान दें:** Supabase की `service_role` key कभी भी सार्वजनिक HTML फाइल में न डालें।

## 🌐 हमारे सोशल मीडिया

- Facebook: https://www.facebook.com/profile.php?id=61588338102063
- Instagram: https://www.instagram.com/mithilanchalvivahmanch/
- WhatsApp: https://wa.me/916299735655

---

**🌺 मिथिलांचल विवाह मंच**

*मैथिल समाज के योग्य वर-वधू को जोड़बाक एकटा नव पहल।*
