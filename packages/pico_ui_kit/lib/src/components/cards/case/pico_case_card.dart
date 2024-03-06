import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:pico_ui_kit/pico_ui_kit.dart';
import 'package:pico_ui_kit/src/components/cards/case/enums/pico_case_type.dart';

class PicoCaseCard extends StatelessWidget {
  const PicoCaseCard._({
    required PicoCaseType type,
    required this.total,
    required this.newCase,
  }) : _type = type;

  factory PicoCaseCard.treatment({
    required int total,
    required int newCase,
  }) =>
      PicoCaseCard._(
        type: PicoCaseType.treatment,
        total: total,
        newCase: newCase,
      );
  factory PicoCaseCard.cured({
    required int total,
    required int newCase,
  }) =>
      PicoCaseCard._(
        type: PicoCaseType.cured,
        total: total,
        newCase: newCase,
      );

  factory PicoCaseCard.death({
    required int total,
    required int newCase,
  }) =>
      PicoCaseCard._(
        type: PicoCaseType.death,
        newCase: newCase,
        total: total,
      );

  final PicoCaseType _type;

  final int total;
  final int newCase;

  @override
  Widget build(BuildContext context) => PicoCard(
        padding: EdgeInsets.all(
          PCSpacing.s8.r,
        ),
        borderRadius: PCRadius.sm.r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton.keep(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _type.data(context).bgColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(PCSpacing.s4.r),
                      child: PicoAsset.icon(
                        icon: _type.data(context).iconData,
                        color: _type.data(context).iconColor,
                        size: 12.sp,
                      ),
                    ),
                  ),
                  PCSpacing.s4.w.horizontalSpace,
                  Expanded(
                    child: Text(
                      _type.data(context).label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: PicoTextStyle.bodySm(
                        color: context.picoColors.text.neutral.subtle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PCSpacing.s8.h.verticalSpace,
            Skeleton.replace(
              replacement: ClipRRect(
                borderRadius: BorderRadius.circular(PCSpacing.s8.r),
                child: Container(
                  width: 80.w,
                  height: 20.h,
                  color: context.picoColors.semantic.info.shade100,
                ),
              ),
              child: Text(
                NumberHelper.numberFormat(total),
                style: PicoTextStyle.labelLg(),
              ),
            ),
            PCSpacing.s8.verticalSpace,
            Text(
              StringHelper.formatNewCase(newCase),
              style: PicoTextStyle.bodyXs(
                fontWeight: FontWeight.w700,
                color: context.picoColors.text.neutral.subtle,
              ),
            ),
          ],
        ),
      );
}
