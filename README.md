# 🎓 Student Academic Performance & Institutional Data Mining Project

> مشروع تحليل وتنقيب في البيانات الأكاديمية (Data Mining & Exploratory Data Analysis) لاستكشاف أنماط الأداء الطلابي، نسب الحضور، توزيع الدرجات، والعوامل المؤثرة على المعدل التراكمي (GPA).

---

## 🚀 1. Project Overview (نظرة عامة على المشروع)
يهدف هذا المشروع إلى تطبيق تقنيات التنقيب في البيانات (`Data Mining`) واستكشاف البيانات الاستكشافية (`EDA`) على قاعدة بيانات أكاديمية شاملة تضم طلاباً، مقررات دراسية، ومسجلين. يركز المشروع على اكتشاف الأنماط الخفية، تحليل نسب الغياب والحضور، دراسة تأثير الدرجات النصفية والنهائية، وتحديد العوامل الحرجة التي تؤثر على تحصيل الطلاب الأكاديمي.

---

## 🛠️ 2. Tech Stack & Tools (الأدوات والتقنيات المستخدمة)
* **Python (Data Mining & Analysis):**
  * **Pandas & NumPy:** لتنظيف، معالجة، ومعالجة القيم المفقودة (`Missing Values Handling`).
  * **Matplotlib & Seaborn:** لتوليد الرسوم البيانية المتقدمة (Density Plots, Boxplots, Correlation Heatmaps).
  * **Scikit-learn / Statistical Analysis:** لتحليل الارتباطات واختبارات الفرضيات الإحصائية (Chi-squared tests, OLS Trend Lines).

---

## 📊 3. Key Findings & Insights (أهم النتائج والرؤى المستخرجة)
1. **تحليل القيم المفقودة (Missing Values Overview):** تبين أن البيانات المفقودة مركزة في تواريخ التسجيل وتواريخ الميلاد (`EnrollmentDate`, `DateOfBirth`) بنسب تتراوح بين 8% إلى 9%، وتم التعامل معها بمنهجية دقيقة لضمان سلامة النماذج.
2. **معدلات الحضور (Attendance Rate Analysis):** أظهر التوزيع التراكمي أن **35.9% من الطلاب يقعون تحت عتبة الحضور الحرجة (75%)**، مما يشكل مؤشراً هاماً للطلاب المعرضين للخطر الأكاديمي (`At-risk Population`).
3. **الارتباطات الأكاديمية (Correlation Heatmap):** أظهرت المصفوفة ارتباطاً قوياً بين درجات الامتحانات النهائية ومجموع النقاط (`GradePoints` بنسبة r = 0.53)، بينما كان الارتباط بين معدل الحضور والمجموع الكلي منعدماً تقريباً، مما يشير إلى أن الحضور وحده لا يضمن التفوق دون جودة التحصيل العلمي.
4. **الأداء حسب الأقسام (GPA by Department):** تتقارب معدلات الأقسام الستة بين 2.08 و 2.24، حيث يتصدر قسم علوم الحاسب (`Computer Science`) بـ 2.24، مما يدل على عوامل مؤسسية عامة تؤثر على المعدلات العامة.

---

## 📸 4. Project Visualizations (لقطات من التحليلات والرسوم البيانية)

### 🔹 تحليل القيم المفقودة وتوزيعها:
![Missing Values](assets/missing_values.png)

### 🔹 توزيع الدرجات والإحصاءات الوصفية (Score Distributions):
![Score Distributions](assets/score_distributions.png)

### 🔹 مصفوفة الارتباط والعلاقات الثنائية (Correlation Heatmap):
![Correlation Heatmap](assets/correlation_heatmap.png)

---

## 👨‍💻 Author (إعداد)
* **Osama Mohamed** - [GitHub Profile](https://github.com/Osama0Mohamed0DataAnalysis)
