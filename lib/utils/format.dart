import 'package:filcnaplo/data/context/app.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:filcnaplo/generated/i18n.dart';

const Locale de_DE = Locale("de", "DE");
const Locale hu_HU = Locale("hu", "HU");
const Locale en_US = Locale("en", "US");

Map<String, Locale> languages = {
  "en_US": en_US,
  "de_DE": de_DE,
  "hu_HU": hu_HU
};

String capital(String s) =>
    s != null ? s.length > 0 ? s[0].toUpperCase() + s.substring(1) : "" : null;

String capitalize(String s) =>
    s != null ? s.split(" ").map((w) => capital(w)).join(" ") : null;

String formatDate(BuildContext context, DateTime date,
    {bool showTime = false, bool weekday = true}) {
  if (date == null || context == null) return null;

  DateTime current = DateTime.now();

  int day = int.parse(DateFormat("D").format(date));
  int currentDay = int.parse(DateFormat("D").format(current));

  if (date.year == current.year) {
    if (weekday == false) {
      return DateFormat("MMM d", app.settings.locale.toString()).format(date);
    }

    if (day == currentDay) {
      if (date.hour != null)
        return DateFormat.Hm().format(date);
      else
        return I18n.of(context).dateToday;
    } else if (day - 1 == currentDay) {
      return I18n.of(context).dateTomorrow;
    } else if (day + 1 == currentDay) {
      return I18n.of(context).dateYesterday;
    } else if ((currentDay - day).abs() < 6 && date.weekday < current.weekday) {
      if (showTime == true)
        return DateFormat("E, HH:mm", app.settings.locale.toString())
            .format(date);
      else
        return DateFormat("E", app.settings.locale.toString()).format(date);
    } else {
      if (date.hour != null && showTime == true)
        return DateFormat("MMM d, HH:mm", app.settings.locale.toString())
            .format(date);
      else
        return DateFormat("MMM d", app.settings.locale.toString()).format(date);
    }
  } else {
    if (date.hour != null && showTime == true)
      return DateFormat("yyyy. MM. dd. HH:mm").format(date);
    else
      return DateFormat("yyyy. MM. dd.").format(date);
  }
}

String escapeHtml(String htmlString) {
  if (htmlString == null) return null;
  htmlString = htmlString.replaceAll("\r", "");
  htmlString = htmlString.replaceAll("<br>", "\n");
  htmlString = htmlString.replaceAll("<p>", "");
  htmlString = htmlString.replaceAll("</p>", "\n");
  var document = parse(htmlString);
  String parsedString = parse(document.body.text).documentElement.text;
  return parsedString;
}
