
import 'package:idsr/data/idsr/models/threshold_model.dart';

class DiseaseConstants {


//case 0 green 1red

  static const case1 = [

    "tASnL2CiPUW", //Meningococcal Meningitis
    "UUVciIZvzgI", //Meningitis
    "X38tNkb8zJP", //Acute and chronic viral hepatitis
    "ViVHNoRgjrD", //Acute hemorrhagic fever syndrome
    "ogemQjHIFom", //Adverse Events Following Immunization (AEFI)
    "fRXN19uY8By", //Anthrax
    "o5hYIC7ouai", //Brucellosis
    "GUU5O1iykrI", //Chikungunya
    "ukZMoIZn8MS", //Cholera
    "DUcdet3Icfo", //COVID-19
    "MkiC5E9WErM", //Dengue fever
    "YaABHnuwxTB", //dengue
    "GlYTdyXCIjv", //Diphtheria
    "hCooV05L1aN", //Ebola virus disease
    "XK2xqlJZNzp", //Envenomation
    "GfcoocXuFLY", //Food Poisoning
    "zEcllGz5Jbx", //Foodborne illness
    "KLLKp8H5sMi", //Guinea worm
    "KwNMW8XVcgQ", //Hepatitis B
    "tztclMKk4y7", //Hepatitis E
    "wSmzTkhakG0", //human influenza (new subtype)
    "qYOZDORetFc", //Influenza-AH1N1
    "wStioC98NFw", //Influenza-like Illness
    "fDdJakyvLyT", //Jaundice
    "KsTDm9HNhNX", //Lassa fever
    "E15yBIViO0L", //Maternal deaths
    "EzEcr3OZzin", //Monkeypox
    "jkBOHgI0LNN", //Neonatal deaths
    "EsL4i0DZeR5", //Neonatal tetanus
    "c7PL1Igc9Do", //Other deaths
    "p9HJ40zEyO3", //Perinatal deaths
    "eQM8t4Ju1UZ", //Plague
    "MPwasrY9aQp", //Post-Infant deaths
    "kgtVjIwLzWr", //Rabies
    "BoHWGezb7JV", //Rift Valley Fever
    "aPOrv6NBj2S", //Rotavirus
    "tonAbvniFDO", //Schistosomiasis
    "xdYrAVn3m8T", //Scorpion stings
    "RoL64HYImyI", //Severe Acute Respiratory Infections (SARIs)
    "DnciOwKxlnF", //Severe Acute Respiratory Syndrome (SARS)
    "uqt1wH3VT10", //Smallpox
    "XMKChwxWPW2", //Snake bites
    "mE1SU1QTtyl", //Tetanus
    "V2DJDZ4AiSu", //Typhoid Fever
    "Sdvbwlrp91W", //Typhus
    "lafrMBOyQAX", //Unexplained cluster of deaths
    "NjX6RWUGjDh", //Unexplained cluster of health events
    "OnAsED4R5FF", //Viral haemorrhagic fever
    "xQ7bPvl6S0D", //Yaws
    "TeO2743rmWJ", //Yellow fever
    "U5Oy2iY5xnF", //Zika virus disease
    "e6AlFS8UJKf", //Under 5 years death
    "nd8iWmomefD", //Haemophilus Influenza B
    "mprpwZhhP81", //Human Exposure to Animal Bites
    "pdoAtkQtbKb", //West Nile
    "fbPcStr16KC", //Dog bites,
    "PBi5fmxDUk7", // Any PH Event of Int Concern
    "hxIVNpEyhDX", //Arbovirus
    "iZCrdtMUq7l", //Burili Ulcer
    "g1YL9Kdlg6s", //Crimean congo hemorrhagic fever
    "MsHGoF6HMeY", //Animal bite
    "qYOZDORetFc", //Influenza-AH5N1
    "HX2koAbWREW", //Measles
    "DVV4llm8zW9", //Poliomyelitis (Acute flaccid paralysis)
    "gGOXjTKEB1O", //Post-neonatal deaths
    "Xdk8YAM1uQ9", //Public health emergencies of international concern
    "u1nch2EQysl", //Scabies
    "HFhqE1Zutzm", //Viral haemorrhagic fever
    "oVcb1153YFs", //Hepatitis A
    "eKRWv5KJ0GH", //Rash fever syndrome
    "kB4yc3Zy9kS", //Typhoid
    "V2DJDZ4AiSu", //Typhoid fever
    "ElYI7SzmhWj", //Salmonella
  ];

//relative
  static const caseWeek = [
    "r4oSb4qmVqY", //Chickenpox
    "lSVksMW4tLi", //Conjunctivitis
    "AEAYXVSFLEj", //Diarrhoea with blood
    "A8JsnfArzCo", //Diarrhoea with dehydration
    "UNOKOq7MbQH", //Gastroenteritis
    "MKTwIVymtgG", //Gunshot Wound
    "qqTjyURqhD8", //Influenza
    "aewmunm4CrM", //Injuries
    "ckeKU9v98dK", //Listeriosis
    "OApMRjrOT9v", //Long Last Fever
    "sZyndtNcGKu", //Moderate malnutrition
    "YsiL2yulRJr", //New HIV/AIDS
    "EanJW8rtPWE", //Pneumonia
    "Jw1noQ4H7i1", //Relapsing Fever
    "eJviPLpSeZx", //Severe malnutrition
    "GTfxF7u27Rt", // Skin Disease
    "cVxpOWYpDbu", //Trypanosomiasis
    "CBuDqQnwYMH", //Tuberculosis
    "j5mXRPYEs0e", //Whooping cough
    "cK6U8zSSvpS", //Lymphatic Filariasis
    "fUA4neaGHLS", //Leptospirosis
    "D4FnFN4OU3G", //Presumptive Multi-Drug Resistance (MDR) TB,
    "XYz2ci4tlM9", //Trichomoniasis
    "FreZlvIdE5p", //Toxoplasmosis,
    "dmyaIHPAZlp", //Strongyloidiasis
    "sB3Bc9MWyUn", //Serological Syphillis
    "DJqn9AqTgKQ", //Road accidents
    "R2MwBF8dFxG", //Pulmonary Tuberculosis
    "TH50gUTAUp7", //Extra pulmonary tuberculosis
    "XpSD0sUl3v6", //Pneumocytosis
    "tJjiX2HLVkJ", //Pelvic Inflammatory Disease
    "rdqYxkZmMQE", //Non-Gonococcal urethritis\
    "V9RzX0bvL8d", //Non-Gonococcal cervicitis
    "s7Bnp9CkdHE", //New Metabolic syndrome(new)
    "j6Cjqs9WHY7", //New Metabolic syndrome(chronic)
    "h5YOo2FxT4s", //Myocardial Infarction
    "mggCvIBDhUl", //Miliary Tuberculosis
    "pu1nJ4uucp1", //Microcephaly
    "e2cpObMOhpl", //Malnutrition
    "UKTKMH7wLD7", //Hypertension(new)
    "CUaotAnGqOZ", //Hypertension(chronic)
    "DAb9R4v2pPq", //Herpes Zoster
    "hZx52CCvdmg", //Herpes Simplex
    "rMFyPOGToPj", //Hand,Foot & Mouth
    "KLvWqI9LpIt", //Gonorrhoea
    "cK6U8zSSvpS", //Filariasis
    "HDR9mipSqng", //Diabetes Mellitus(new)
    "NEZhzDHozFJ", //Diabetes Mellitus(chronic)
    "AUlM8KQVwib", //Cytomegalovirus
    "i2AoKygdfsz", //Congenital syphilis
    "SA0PnzgZq5I", //Chlamydia trachomatis
    "qBiiPSBYeM0", //Chancroid
    "TLQx0ynyUjw", //Caterpillar Rash
    "J0IWv2bRcUS", //Candidiasis
    "xN7FHjAiqBa", //Bacterial Vaginosis
    "wUfroLisZ3l", //Viral Meningitis
    "dg6Dj9WXzV0", //Anogenital Warts
    "pF16LhMLEJW", //Anogenital Herpes
  ];

//MMR

  static const mmr = [
    "HX2koAbWREW", //Measles
    "YM4V9tKEzNk", //Mumps
    "w8QUcdzIYP3", //Rubella
  ];

//Meningitis
  static const meningitis = [
    "tASnL2CiPUW", //Meningococcal Meningitis
    "UUVciIZvzgI", //Meningitis
  ];

//malaria
  static const malaria = [
    "FDXEITNr2Y7" //malaria
  ];

  static const DISEASE_BY_COUNTRY={
    "angola":["FDXEITNr2Y7","eKRWv5KJ0GH","fDdJakyvLyT","MsHGoF6HMeY","SkRMprMNgfr","P8ixGmWNJQX","UUVciIZvzgI","MkiC5E9WErM","TKn4iH1M4YR","GUU5O1iykrI","DnciOwKxlnF","mE1SU1QTtyl","j5mXRPYEs0e","pu1nJ4uucp1","OnAsED4R5FF","U5Oy2iY5xnF","eQM8t4Ju1UZ","e2cpObMOhpl","CBuDqQnwYMH","V2DJDZ4AiSu","tonAbvniFDO","DJqn9AqTgKQ","sChMJfJkNwV"],
    "burundi":["EsL4i0DZeR5","ukZMoIZn8MS","AEAYXVSFLEj","OnAsED4R5FF","OnAsED4R5FF","JxR7oFTdW31","FDXEITNr2Y7","HX2koAbWREW","BoHWGezb7JV","EzEcr3OZzin","DUcdet3Icfo","E15yBIViO0L","jkBOHgI0LNN","p9HJ40zEyO3"],
    "benin":["EzEcr3OZzin","ogemQjHIFom","KsTDm9HNhNX","UUVciIZvzgI","kgtVjIwLzWr","IpWM7iGAwK2","MkiC5E9WErM","TeO2743rmWJ","GfcoocXuFLY","hV1dK8rfTaG","HX2koAbWREW","E15yBIViO0L","P8ixGmWNJQX","jkBOHgI0LNN"],
    "botswana":["psMobjTC7Qd","hV1dK8rfTaG","ukZMoIZn8MS","A8JsnfArzCo","AEAYXVSFLEj","DUcdet3Icfo","GlYTdyXCIjv","FDXEITNr2Y7","HX2koAbWREW","tASnL2CiPUW","EsL4i0DZeR5","eQM8t4Ju1UZ","ndVnerowra8","SkRMprMNgfr","V2DJDZ4AiSu","TeO2743rmWJ","OnAsED4R5FF"],
    "burkanfaso":["fRXN19uY8By","AEAYXVSFLEj","ukZMoIZn8MS","DUcdet3Icfo","MkiC5E9WErM","GCj99VB82V9","HquNO4YFWZZ","KLLKp8H5sMi","wSmzTkhakG0","fDdJakyvLyT","KsTDm9HNhNX","FDXEITNr2Y7","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","P8ixGmWNJQX","p9HJ40zEyO3","JxR7oFTdW31","BoHWGezb7JV","DnciOwKxlnF","U5Oy2iY5xnF"],
    "car":["ogemQjHIFom","hV1dK8rfTaG","ovO9650Pjxk","DUcdet3Icfo","qqTjyURqhD8","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","sZyndtNcGKu","EzEcr3OZzin","eJviPLpSeZx","IpWM7iGAwK2","V2DJDZ4AiSu","j5mXRPYEs0e","TeO2743rmWJ"],
    "rwanda":["o5hYIC7ouai","DUcdet3Icfo","HquNO4YFWZZ","K0AcHmPT6Fz","ndVnerowra8","EanJW8rtPWE","FDXEITNr2Y7","cVxpOWYpDbu","hV1dK8rfTaG","ViVHNoRgjrD","fRXN19uY8By","tASnL2CiPUW","WcqAEnsLJOM","r4oSb4qmVqY","GUU5O1iykrI","ukZMoIZn8MS","YaABHnuwxTB","KLLKp8H5sMi","Sdvbwlrp91W","zEcllGz5Jbx","SkRMprMNgfr","wSmzTkhakG0","E15yBIViO0L","HX2koAbWREW","EsL4i0DZeR5","p9HJ40zEyO3","eQM8t4Ju1UZ","Xdk8YAM1uQ9","BoHWGezb7JV","w8QUcdzIYP3","RoL64HYImyI","DnciOwKxlnF","RRc2TUbhbXu","uqt1wH3VT10","XMKChwxWPW2","V2DJDZ4AiSu","e6AlFS8UJKf","xQ7bPvl6S0D","TeO2743rmWJ","U5Oy2iY5xnF"],
    "congo":["EzEcr3OZzin","hV1dK8rfTaG","ukZMoIZn8MS","DUcdet3Icfo","fbPcStr16KC","GCj99VB82V9","qqTjyURqhD8","FDXEITNr2Y7","E15yBIViO0L","jkBOHgI0LNN","P8ixGmWNJQX","eQM8t4Ju1UZ","kgtVjIwLzWr","DJqn9AqTgKQ","IpWM7iGAwK2","TeO2743rmWJ","o8b1zA8cdjW","GUU5O1iykrI","gGOXjTKEB1O"],
    "drc":["hV1dK8rfTaG","ovO9650Pjxk","Z8pb3cLMt8C","ogemQjHIFom","DUcdet3Icfo","GUU5O1iykrI","ukZMoIZn8MS","AEAYXVSFLEj","A8JsnfArzCo","GlYTdyXCIjv","KLLKp8H5sMi","qqTjyURqhD8","FDXEITNr2Y7","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","EzEcr3OZzin","P8ixGmWNJQX","eQM8t4Ju1UZ","kgtVjIwLzWr","DT7GyUfXjmU","V2DJDZ4AiSu","j5mXRPYEs0e","TeO2743rmWJ"],
    "gabon":["hV1dK8rfTaG","fRXN19uY8By","PBi5fmxDUk7","GUU5O1iykrI","ukZMoIZn8MS","YaABHnuwxTB","AEAYXVSFLEj","u3UeqLbAW34","qqTjyURqhD8","CT9T9XNnPrn","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","EsL4i0DZeR5","eQM8t4Ju1UZ","kgtVjIwLzWr","DnciOwKxlnF","V2DJDZ4AiSu","OnAsED4R5FF","TeO2743rmWJ"],
    "cameeroon":["hV1dK8rfTaG","fRXN19uY8By","GUU5O1iykrI","ukZMoIZn8MS","DUcdet3Icfo","YaABHnuwxTB","AEAYXVSFLEj","A8JsnfArzCo","GlYTdyXCIjv","fbPcStr16KC","KLLKp8H5sMi","wStioC98NFw","FDXEITNr2Y7","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","EzEcr3OZzin","P8ixGmWNJQX","jkBOHgI0LNN","p9HJ40zEyO3","eQM8t4Ju1UZ","kgtVjIwLzWr","DnciOwKxlnF","uqt1wH3VT10","XMKChwxWPW2","V2DJDZ4AiSu","OnAsED4R5FF","TeO2743rmWJ","XK2xqlJZNzp"],
    "chad":["TKn4iH1M4YR","GUU5O1iykrI","ukZMoIZn8MS","DUcdet3Icfo","fbPcStr16KC","UNOKOq7MbQH","KLLKp8H5sMi","CTrTVmIjNzL","tztclMKk4y7","O4nY6lrId9Z","FDXEITNr2Y7","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","sZyndtNcGKu","P8ixGmWNJQX","p9HJ40zEyO3","xdYrAVn3m8T","eJviPLpSeZx","XMKChwxWPW2","TeO2743rmWJ"],
    "stp":["ovO9650Pjxk","AEAYXVSFLEj","ukZMoIZn8MS","MkiC5E9WErM","moL2l8aGdbu","qqTjyURqhD8","FDXEITNr2Y7","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","P8ixGmWNJQX","IlIvSGtLtKp","OnAsED4R5FF","TeO2743rmWJ","lSVksMW4tLi"],
    "ivorycost":[ "ukZMoIZn8MS","MkiC5E9WErM","KLLKp8H5sMi","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","jkBOHgI0LNN","JxR7oFTdW31","TeO2743rmWJ"],
    "ghana":[ "hV1dK8rfTaG","j0XfneLU7Ab","fRXN19uY8By","ukZMoIZn8MS","DUcdet3Icfo","MkiC5E9WErM","AEAYXVSFLEj","K97MiimiwZ4","psMobjTC7Qd","HX2koAbWREW","UUVciIZvzgI","EzEcr3OZzin","P8ixGmWNJQX","eQM8t4Ju1UZ","kgtVjIwLzWr","TeO2743rmWJ"],
    "guinea":[ "AEAYXVSFLEj","ukZMoIZn8MS","GCj99VB82V9","FDXEITNr2Y7","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","jkBOHgI0LNN","JxR7oFTdW31","zLZp0cdpp4L","EeyW836OWBY","TeO2743rmWJ"],
    "gambia":[ "ukZMoIZn8MS","Mv586ITYHXU","DUcdet3Icfo","MkiC5E9WErM","AEAYXVSFLEj","Uzey185qdrz","cK6U8zSSvpS","HX2koAbWREW","UUVciIZvzgI","P8ixGmWNJQX","tonAbvniFDO","sAnOcxFZERs","SA0PnzgZq5I","TeO2743rmWJ"],
    "guneabissau":[ "hV1dK8rfTaG","L3oDlTkYOYx","fRXN19uY8By","ukZMoIZn8MS","MkiC5E9WErM","AEAYXVSFLEj","u3UeqLbAW34","wStioC98NFw","HX2koAbWREW","UUVciIZvzgI","EsL4i0DZeR5","eQM8t4Ju1UZ","kgtVjIwLzWr","TeO2743rmWJ"],
    "kenya":[ "fDdJakyvLyT","E8xXW3nZjHe","ogemQjHIFom","fRXN19uY8By","ukZMoIZn8MS","MkiC5E9WErM","HeuuSWgq7Ut","KLLKp8H5sMi","FDXEITNr2Y7","E15yBIViO0L","HX2koAbWREW","tASnL2CiPUW","P8ixGmWNJQX","jkBOHgI0LNN","OnAsED4R5FF","Qq0BuaDYBmO","eQM8t4Ju1UZ","hV1dK8rfTaG","kgtVjIwLzWr","BoHWGezb7JV","RoL64HYImyI","V2DJDZ4AiSu","TeO2743rmWJ"],
    "madagascar":[ "hV1dK8rfTaG","j0XfneLU7Ab","fRXN19uY8By","hxIVNpEyhDX","ukZMoIZn8MS","DUcdet3Icfo","AEAYXVSFLEj","K97MiimiwZ4","psMobjTC7Qd","FDXEITNr2Y7","HX2koAbWREW","UUVciIZvzgI","EsL4i0DZeR5","eQM8t4Ju1UZ","kgtVjIwLzWr","mYALbAWAd53"],
    "malawi": ["ogemQjHIFom","hV1dK8rfTaG","ViVHNoRgjrD","fRXN19uY8By","ukZMoIZn8MS","DUcdet3Icfo","YaABHnuwxTB","AEAYXVSFLEj","wSmzTkhakG0","ckeKU9v98dK","FDXEITNr2Y7","E15yBIViO0L","HX2koAbWREW","tASnL2CiPUW","P8ixGmWNJQX","eQM8t4Ju1UZ","kgtVjIwLzWr","RoL64HYImyI","DnciOwKxlnF","uqt1wH3VT10","V2DJDZ4AiSu","TeO2743rmWJ"],
    "mali":[ "hV1dK8rfTaG","AEAYXVSFLEj","ukZMoIZn8MS","YaABHnuwxTB","fbPcStr16KC","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","jkBOHgI0LNN","kgtVjIwLzWr","xdYrAVn3m8T","XMKChwxWPW2","j5mXRPYEs0e","TeO2743rmWJ"],
    "mozambike":[ "hV1dK8rfTaG","MsHGoF6HMeY","AEAYXVSFLEj","ukZMoIZn8MS","DUcdet3Icfo","qqTjyURqhD8","FDXEITNr2Y7","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","P8ixGmWNJQX","eQM8t4Ju1UZ","aPOrv6NBj2S","eJviPLpSeZx","V2DJDZ4AiSu","OnAsED4R5FF"],
    "maurtania":[ "ovO9650Pjxk","DUcdet3Icfo","r4oSb4qmVqY","ukZMoIZn8MS","g1YL9Kdlg6s","lSVksMW4tLi","YaABHnuwxTB","fbPcStr16KC","qqTjyURqhD8","FDXEITNr2Y7","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","jkBOHgI0LNN","EsL4i0DZeR5","EanJW8rtPWE","BoHWGezb7JV","tonAbvniFDO","RoL64HYImyI","DT7GyUfXjmU","CBuDqQnwYMH"],
    "namibia":[ "hV1dK8rfTaG","ogemQjHIFom","fRXN19uY8By","PBi5fmxDUk7","ukZMoIZn8MS","DUcdet3Icfo","g1YL9Kdlg6s","tztclMKk4y7","wStioC98NFw","FDXEITNr2Y7","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","YM4V9tKEzNk","EsL4i0DZeR5","eQM8t4Ju1UZ","kgtVjIwLzWr","u1nch2EQysl","tonAbvniFDO","RoL64HYImyI","DnciOwKxlnF","COIIzg2uhct","V2DJDZ4AiSu","TeO2743rmWJ",],
    "niger":[ "ukZMoIZn8MS","MkiC5E9WErM","AEAYXVSFLEj","GlYTdyXCIjv","KLLKp8H5sMi","tztclMKk4y7","qqTjyURqhD8","FDXEITNr2Y7","HX2koAbWREW","UUVciIZvzgI","EsL4i0DZeR5","tCDAb2mHw7c","kgtVjIwLzWr","BoHWGezb7JV","mE1SU1QTtyl","j5mXRPYEs0e","TeO2743rmWJ"],
    "nigeria":["ukZMoIZn8MS","KsTDm9HNhNX","HX2koAbWREW","UUVciIZvzgI","UUVciIZvzgI","TeO2743rmWJ"],
    "senegal":[ "BN2Jd9sk6jX","ogemQjHIFom","hV1dK8rfTaG","MsHGoF6HMeY","rcSFHIl36fp","nwvXyyuZiXp","SKgoZ5rQckt","ukZMoIZn8MS","DUcdet3Icfo","YaABHnuwxTB","fbPcStr16KC","XQTBvF5qtaK","hCooV05L1aN","Cmu6ToPqZo6","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","sZyndtNcGKu","ryB5ZQXWD9n","jkBOHgI0LNN","P8ixGmWNJQX","t3crXaOsyek","EanJW8rtPWE","xdYrAVn3m8T","eJviPLpSeZx","XMKChwxWPW2","CBuDqQnwYMH","OnAsED4R5FF","j5mXRPYEs0e","TeO2743rmWJ"],
    "sieraleone":["ogemQjHIFom","fRXN19uY8By","iZCrdtMUq7l","ukZMoIZn8MS","DUcdet3Icfo","YaABHnuwxTB","moL2l8aGdbu","fbPcStr16KC","KLLKp8H5sMi","fDdJakyvLyT","FDXEITNr2Y7","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","EzEcr3OZzin","jkBOHgI0LNN","eQM8t4Ju1UZ","EanJW8rtPWE","IlIvSGtLtKp","eJviPLpSeZx","IpWM7iGAwK2","XMKChwxWPW2","mE1SU1QTtyl","V2DJDZ4AiSu","OnAsED4R5FF","TeO2743rmWJ"],
    "southsudan":["uqwbvL4LnL9","UL3ecGkTP1B","ovO9650Pjxk","BN2Jd9sk6jX","hV1dK8rfTaG","ukZMoIZn8MS","DUcdet3Icfo","KLLKp8H5sMi","MKTwIVymtgG","aewmunm4CrM","FDXEITNr2Y7","HX2koAbWREW","UUVciIZvzgI","EsL4i0DZeR5","Qq0BuaDYBmO","Jw1noQ4H7i1","GTfxF7u27Rt","rKOiQ2z9JUZ","OnAsED4R5FF","TeO2743rmWJ"],
    "southafrica":["TKn4iH1M4YR","cLf6v6V6bZ4","ukZMoIZn8MS","YDvZXy93KIz","DUcdet3Icfo","VMXwYcn47pD","g1YL9Kdlg6s","GlYTdyXCIjv","V2DJDZ4AiSu","zEcllGz5Jbx","uQ2d6TDBsrR","ckeKU9v98dK","FDXEITNr2Y7","HX2koAbWREW","tASnL2CiPUW","j5mXRPYEs0e","kgtVjIwLzWr","I50iFcOHIRf","kB4yc3Zy9kS","EzEcr3OZzin","ovO9650Pjxk","w8QUcdzIYP3","hV1dK8rfTaG"],
    "seychelle":["X38tNkb8zJP","YsiL2yulRJr","pF16LhMLEJW","dg6Dj9WXzV0","fRXN19uY8By", "aH0ajws4SwF","xN7FHjAiqBa","J0IWv2bRcUS","TLQx0ynyUjw","qBiiPSBYeM0","r4oSb4qmVqY","GUU5O1iykrI","SA0PnzgZq5I","ukZMoIZn8MS","i2AoKygdfsz","lSVksMW4tLi","DUcdet3Icfo","AUlM8KQVwib","MkiC5E9WErM","NEZhzDHozFJ","HDR9mipSqng","HeuuSWgq7Ut","TH50gUTAUp7","GlYTdyXCIjv","cK6U8zSSvpS","KLvWqI9LpIt","nd8iWmomefD","rMFyPOGToPj","oVcb1153YFs","KwNMW8XVcgQ","NGhrPAoReRa","hZx52CCvdmg","DAb9R4v2pPq","YsiL2yulRJr","W4taT4oSLml","UKTKMH7wLD7","qqTjyURqhD8","Uzey185qdrz","fUA4neaGHLS", "ckeKU9v98dK","FDXEITNr2Y7","HX2koAbWREW","tASnL2CiPUW","mggCvIBDhUl","EzEcr3OZzin","noN0DeAV2qE","YM4V9tKEzNk","h5YOo2FxT4s","s7Bnp9CkdHE","j6Cjqs9WHY7","V9RzX0bvL8d","rdqYxkZmMQE","tJjiX2HLVkJ","XpSD0sUl3v6","EanJW8rtPWE","EanJW8rtPWE", "DVV4llm8zW9","R2MwBF8dFxG","w8QUcdzIYP3","ElYI7SzmhWj","DnciOwKxlnF","u1nch2EQysl","sB3Bc9MWyUn","dmyaIHPAZlp","EuUSeBRAA96","mE1SU1QTtyl","EsL4i0DZeR5","FreZlvIdE5p","XYz2ci4tlM9","kB4yc3Zy9kS","W4WMlFIsH8e","W4WMlFIsH8e","HFhqE1Zutzm","wUfroLisZ3l","pdoAtkQtbKb","j5mXRPYEs0e","TeO2743rmWJ"],
    "togo":["fRXN19uY8By","hV1dK8rfTaG","AEAYXVSFLEj","ukZMoIZn8MS","DUcdet3Icfo","MkiC5E9WErM","GlYTdyXCIjv","KLLKp8H5sMi","qqTjyURqhD8","d2tnrJl3XvG","qYOZDORetFc","OApMRjrOT9v","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","P8ixGmWNJQX","jkBOHgI0LNN","EanJW8rtPWE","kgtVjIwLzWr","RoL64HYImyI","HPke5XU4ZZY","cVxpOWYpDbu","V2DJDZ4AiSu","OnAsED4R5FF","j5mXRPYEs0e"],
    "uganda":[ "TKn4iH1M4YR","ogemQjHIFom","MsHGoF6HMeY","ukZMoIZn8MS","HeuuSWgq7Ut","KLLKp8H5sMi","KwNMW8XVcgQ","FDXEITNr2Y7","HX2koAbWREW","UUVciIZvzgI","EsL4i0DZeR5","eQM8t4Ju1UZ","RoL64HYImyI","V2DJDZ4AiSu"],
    "zambia":["fRXN19uY8By","VQifiMFdfDA","ukZMoIZn8MS","DUcdet3Icfo","A8JsnfArzCo","fbPcStr16KC","HeuuSWgq7Ut","YsiL2yulRJr","CT9T9XNnPrn","FDXEITNr2Y7","HX2koAbWREW","UUVciIZvzgI","EsL4i0DZeR5","eQM8t4Ju1UZ","DVV4llm8zW9","kgtVjIwLzWr","cVxpOWYpDbu","CBuDqQnwYMH","V2DJDZ4AiSu","DVV4llm8OnAsED4R5FFzW9","TeO2743rmWJ"],
    "zimbabwe":["fRXN19uY8By","ukZMoIZn8MS","DUcdet3Icfo","moL2l8aGdbu","fbPcStr16KC","HeuuSWgq7Ut","qqTjyURqhD8","wStioC98NFw","FDXEITNr2Y7","HX2koAbWREW","E15yBIViO0L","UUVciIZvzgI","YM4V9tKEzNk","EsL4i0DZeR5","IlIvSGtLtKp","kgtVjIwLzWr","XMKChwxWPW2","V2DJDZ4AiSu"],
    "eswatini":["DVV4llm8zW9","ukZMoIZn8MS","DUcdet3Icfo","GfcoocXuFLY","SkRMprMNgfr","FDXEITNr2Y7","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","jkBOHgI0LNN","p9HJ40zEyO3","BoHWGezb7JV","oz6FMMOdYKJ","V2DJDZ4AiSu","L3oDlTkYOYx","TeO2743rmWJ"],
    "capverde":["hV1dK8rfTaG","AEAYXVSFLEj","ukZMoIZn8MS","MkiC5E9WErM","wStioC98NFw","FDXEITNr2Y7","HX2koAbWREW","UUVciIZvzgI","P8ixGmWNJQX","eQM8t4Ju1UZ","kgtVjIwLzWr","OnAsED4R5FF","TeO2743rmWJ"],
    "comoros":[],
    "lesotho":["hV1dK8rfTaG","ogemQjHIFom","AEAYXVSFLEj","E15yBIViO0L","HX2koAbWREW","V2DJDZ4AiSu"],
    "liberia":["L3oDlTkYOYx","hV1dK8rfTaG","AEAYXVSFLEj","iZCrdtMUq7l","ukZMoIZn8MS","DUcdet3Icfo","MkiC5E9WErM","mprpwZhhP81","qqTjyURqhD8","KsTDm9HNhNX","E15yBIViO0L","HX2koAbWREW","UUVciIZvzgI","EzEcr3OZzin","jkBOHgI0LNN","P8ixGmWNJQX","D4FnFN4OU3G","V5xmO0XfQRb","yV0ue2Hj0Mn","xQ7bPvl6S0D","TeO2743rmWJ"],
    "mauritius":["YaABHnuwxTB","rMFyPOGToPj","wStioC98NFw","FDXEITNr2Y7","HX2koAbWREW"],
    "tanzania":["MsHGoF6HMeY","fRXN19uY8By","AEAYXVSFLEj","r4oSb4qmVqY","GUU5O1iykrI","ukZMoIZn8MS","lSVksMW4tLi","YaABHnuwxTB","moL2l8aGdbu","FDXEITNr2Y7","HX2koAbWREW","UUVciIZvzgI","EsL4i0DZeR5","eQM8t4Ju1UZ","EanJW8rtPWE","IlIvSGtLtKp","kgtVjIwLzWr","RoL64HYImyI","uqt1wH3VT10","cVxpOWYpDbu","V2DJDZ4AiSu","OnAsED4R5FF","TeO2743rmWJ"]

  };
}

class ThresholdService {

  static List<int> isOverThreshold(
      ThresholdModel data,
      String diseaseId,
      String period,
      String previousPeriod,
      String orgUnit,
      ) {
    int over = 0;
    int inside = 0;

    List rows = data.rows;
    for (var r in rows) {
      if (r[0] == diseaseId && r[3] == orgUnit && r[2] == period) {


        int current = int.tryParse(r[4].toString()) ?? 0;
        int last = getLastWeekData(diseaseId, orgUnit, previousPeriod, rows);

        if (current > last &&
            DiseaseConstants.caseWeek.contains(diseaseId)) {
          over++;
        }

        if (current > last * 1.5 &&
            DiseaseConstants.malaria.contains(diseaseId)) {
          over++;
        }

        if (current < last * 1.3 &&
            current > last * 1.1 &&
            DiseaseConstants.malaria.contains(diseaseId)) {
          inside++;
        }

        if (current >= 1 &&
            DiseaseConstants.case1.contains(diseaseId)) {
          over++;
        }

        if (current > 4 &&
            DiseaseConstants.mmr.contains(diseaseId)) {
          over++;
        }

        if (current < 5 &&
            current > 0 &&
            DiseaseConstants.mmr.contains(diseaseId)) {
          inside++;
        }
      }
    }

    return [over, inside];
  }

  static int getLastWeekData(
      String diseaseId,
      String orgUnit,
      String period,
      List rows,
      ) {
    for (var r in rows) {
      if (r[0] == diseaseId && r[3] == orgUnit && r[2] == period) {
        return int.tryParse(r[4].toString()) ?? 0;
      }
    }
    return 0;
  }
}