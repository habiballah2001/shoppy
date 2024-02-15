import 'package:flutter/material.dart';

class BodyLargeText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final Color? color;
  final TextOverflow? overFlow;
  const BodyLargeText(
    this.text, {
    super.key,
    this.maxLines,
    this.color,
    this.overFlow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overFlow,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: color),
    );
  }
}

class BodyMediumText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final Color? color;
  final TextOverflow? overFlow;

  const BodyMediumText(
    this.text, {
    super.key,
    this.maxLines,
    this.color,
    this.overFlow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overFlow,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: color),
    );
  }
}

class BodySmallText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final Color? color;
  final TextOverflow? overFlow;

  const BodySmallText(
    this.text, {
    super.key,
    this.maxLines,
    this.color,
    this.overFlow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overFlow,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: color),
    );
  }
}

class TitleLargeText extends StatelessWidget {
  final String text;
  final Color? color;
  final int maxLines;
  final List<Shadow>? shadow;

  const TitleLargeText(
    this.text, {
    super.key,
    this.color,
    this.maxLines = 1,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: color, shadows: shadow),
      textAlign: TextAlign.center,
    );
  }
}

class TitleMediumText extends StatelessWidget {
  final String text;
  final Color? color;
  final int maxLines;
  final List<Shadow>? shadow;
  const TitleMediumText(
    this.text, {
    super.key,
    this.color,
    this.maxLines = 1,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: color, shadows: shadow),
    );
  }
}

class TitleSmallText extends StatelessWidget {
  final String text;
  final int maxLines;
  final Color? color;
  const TitleSmallText(
    this.text, {
    super.key,
    this.maxLines = 1,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(color: color),
    );
  }
}

class HeadLargeText extends StatelessWidget {
  final String text;
  final Color? color;
  const HeadLargeText(
    this.text, {
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}

class HeadMediumText extends StatelessWidget {
  final String text;
  final Color? color;
  const HeadMediumText(
    this.text, {
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}

class HeadSmallText extends StatelessWidget {
  final String text;
  final Color? color;
  final int maxLines;
  const HeadSmallText(
    this.text, {
    super.key,
    this.color,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}
