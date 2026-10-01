enum EgyptGovernorate {
  cairo('القاهرة'),
  giza('الجيزة'),
  alexandria('الإسكندرية'),
  damietta('دمياط'),
  daqahliya('الدقهلية'),
  sharqia('الشرقية'),
  qalyubia('القليوبية'),
  portSaid('بورسعيد'),
  suez('السويس'),
  northSinai('شمال سيناء'),
  southSinai('جنوب سيناء'),
  ismailia('الإسماعيلية'),
  beheira('البحيرة'),
  kafrElSheikh('كفر الشيخ'),
  gharbia('الغربية'),
  monufia('المنوفية'),
  fayoum('الفيوم'),
  beniSuef('بني سويف'),
  minya('المنيا'),
  assiut('أسيوط'),
  sohag('سوهاج'),
  qena('قنا'),
  luxor('الأقصر'),
  aswan('أسوان'),
  redSea('البحر الأحمر'),
  newValley('الوادي الجديد'),
  matrouh('مطروح');

  final String displayName;
  const EgyptGovernorate(this.displayName);
}