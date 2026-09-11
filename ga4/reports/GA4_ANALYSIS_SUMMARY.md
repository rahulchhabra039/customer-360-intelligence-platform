# GA4 Analysis Summary

## Customer 360 Intelligence Platform

**Property:** GA4 - Google Merch Shop demo property  
**Analysis period:** 28 May 2026 to 25 August 2026 (Last 90 days)  
**Tools used:** GA4 standard reports and Explorations

## 1. Scope

I used the Google Merchandise Shop demo property to look at how users reached the site, how they moved through the ecommerce journey, where they dropped out, and whether mobile and desktop users behaved differently.

The work covered four areas:

1. Traffic acquisition analysis
2. Ecommerce funnel exploration
3. Product-to-purchase path exploration
4. Mobile versus desktop segment comparison

## 2. Headline results

| KPI | Result |
|---|---:|
| Sessions | 348,069 |
| Engaged sessions | 136,279 |
| Engagement rate | 39.15% |
| Average engagement time per session | 43 seconds |
| Event count | 4,185,021 |
| Key events | 291,767 |
| Session key-event rate | 21.59% |
| Total revenue | $587,707.39 |
| Funnel purchase rate | 1.20% |
| Mobile funnel purchase rate | 0.16% |
| Desktop funnel purchase rate | 3.69% |

> The session key-event rate includes every event configured as a key event in the demo property, not just purchases.

## 3. Traffic acquisition analysis

![Traffic acquisition overview](../screenshots/01_traffic_acquisition_overview_90_days.png)

| Channel | Sessions | Engagement rate | Session key-event rate | Revenue | Revenue share |
|---|---:|---:|---:|---:|---:|
| Direct | 217,030 | 24.75% | 12.61% | $334,683.98 | 56.95% |
| Organic Search | 75,691 | 69.15% | 35.60% | $155,934.24 | 26.53% |
| Paid Search | 21,875 | 68.21% | 44.38% | $32,913.31 | 5.60% |
| Unassigned | 17,887 | 13.03% | 22.74% | $7,181.23 | 1.22% |
| Cross-network | 7,958 | 79.73% | 46.82% | $24,851.72 | 4.23% |
| Referral | 5,591 | 72.69% | 35.97% | $26,167.67 | 4.45% |

### Findings

- Direct generated the most traffic and revenue, but its 24.75% engagement rate was much weaker than Organic Search, Paid Search, Cross-network and Referral.
- Organic Search generated 21.75% of sessions but 26.53% of revenue, showing stronger revenue efficiency than Direct.
- Referral generated only 1.61% of sessions but 4.45% of revenue, making it a high-value channel despite its smaller volume.
- Cross-network combined strong engagement (79.73%) with a 46.82% session key-event rate.
- Unassigned contributed 5.14% of sessions but only 1.22% of revenue and had a 13.03% engagement rate. This suggests channel-classification problems, low-quality traffic, or both.

Additional evidence: [engagement metrics](../screenshots/02_traffic_acquisition_engagement_metrics.png) and [revenue metrics](../screenshots/03_traffic_acquisition_revenue_metrics.png).

## 4. Ecommerce funnel exploration

The funnel was configured as a closed, indirectly followed sequence:

`session_start -> view_item -> add_to_cart -> begin_checkout -> purchase`

![Ecommerce conversion funnel](../screenshots/04_ecommerce_funnel_overview_90_days.png)

| Funnel stage | Active users | % of Step 1 | Completion to next stage | Abandonment rate |
|---|---:|---:|---:|---:|
| Session Start | 251,119 | 100.00% | 20.41% | 79.59% |
| View Item | 51,262 | 20.41% | 24.85% | 75.15% |
| Add to Cart | 12,741 | 5.07% | 48.87% | 51.13% |
| Begin Checkout | 6,226 | 2.48% | 48.22% | 51.78% |
| Purchase | 3,002 | 1.20% | - | - |

### Findings

- The largest loss occurred between Session Start and View Item: 79.59% did not reach a product-view event within the closed funnel sequence.
- A further 75.15% of product viewers did not progress to Add to Cart.
- Approximately half of cart users progressed to checkout, and approximately half of checkout users completed a purchase.
- The overall Session Start to Purchase rate was 1.20%.
- The earliest two stages offer the largest volume opportunity because improvements there affect a much larger user base.

Detailed evidence: [funnel stage results](../screenshots/05_ecommerce_funnel_stage_results.png).

## 5. Product-to-purchase path exploration

The forward path began at `view_item` to examine immediate event sequences after a product view.

![Path after product view](../screenshots/06_product_path_after_view_item.png)

### Selected path findings

- The starting point contained 75,941 `view_item` events.
- The most common immediate next event was `view_item_list` (28,413), indicating substantial continued browsing.
- `add_to_cart` was the immediate next event 4,869 times.
- After the selected `add_to_cart` node, 489 paths moved immediately to `view_cart`; 786 returned to a product list; and 70 recorded `remove_from_cart`.
- After the selected cart-related `page_view`, 239 of 446 paths moved immediately to `begin_checkout`.
- Of those 239 checkout-start paths, 232 moved immediately to `add_shipping_info`.
- After the following checkout page view, 125 of 232 paths moved to `add_payment_info`.
- After payment information and the next selected page view, 35 of 116 paths recorded `purchase` as the immediate next event.

The path also showed users returning to product lists, revisiting the cart, restarting checkout and triggering new sessions. The ecommerce journey is therefore not perfectly linear.

Supporting evidence: [cart-to-checkout path](../screenshots/07_product_path_cart_to_checkout.png) and [payment-to-purchase path](../screenshots/08_product_path_payment_to_purchase.png).

> Path Exploration reports immediate event-node sequences. These counts are event-path counts, not complete user-conversion rates. Funnel Exploration is the correct source for stage conversion and abandonment rates.

## 6. Mobile versus desktop segment comparison

The existing Mobile traffic segment was compared with GA4's Web traffic segment, whose condition is `Device category = desktop`.

![Mobile versus desktop funnel](../screenshots/09_mobile_vs_desktop_funnel_comparison.png)

| Funnel stage | Mobile active users | Mobile completion | Desktop active users | Desktop completion |
|---|---:|---:|---:|---:|
| Session Start | 176,519 | 11.64% | 73,463 | 41.42% |
| View Item | 20,539 | 18.38% | 30,429 | 29.37% |
| Add to Cart | 3,775 | 34.09% | 8,938 | 55.18% |
| Begin Checkout | 1,287 | 21.91% | 4,932 | 54.99% |
| Purchase | 282 (0.16% of Step 1) | - | 2,712 (3.69% of Step 1) | - |

### Findings

- Desktop's overall funnel purchase rate was 3.69%, compared with 0.16% for mobile. Desktop therefore converted approximately 23 times better.
- Mobile began with more than twice as many active users, but desktop generated almost ten times as many purchasers.
- The gap appeared at every stage, beginning with product discovery: 41.42% of desktop users reached View Item compared with 11.64% of mobile users.
- The largest late-stage difference was checkout completion: 54.99% for desktop versus 21.91% for mobile.
- The same pattern appeared at every stage, so both the mobile experience and the mobile event setup need to be checked.

## 7. Recommendations

1. Check that `view_item`, `add_to_cart`, `begin_checkout` and `purchase` fire consistently on mobile and desktop.
2. Review mobile navigation, search, product-list links, page speed and add-to-cart buttons.
3. Check the mobile checkout for long forms, validation errors, missing payment options and poor autofill support.
4. Use consistent UTM tagging and review referral handling to reduce Direct and Unassigned traffic.
5. Continue monitoring Organic Search, Referral and Cross-network because they showed good engagement or revenue efficiency.
6. Track the device-level funnel regularly so that a conversion change or tracking problem is noticed early.

## 8. Limitations

- This is Google's public GA4 demo property, not a business-owned production property.
- The 90-day window is live and counts may change slightly as the demo property refreshes.
- The GA4 interface analysis and the project's BigQuery public export use different analytical contexts and should not be directly reconciled without aligned dates, definitions and scopes.
- Active users, sessions and event counts are different measurement scopes and must not be used interchangeably.
- The session key-event rate includes all configured key events, not only purchases.
- Path Exploration shows immediate event sequences and does not establish causality.
- The results show where further investigation is needed, but they do not prove whether a gap is caused by user experience, traffic quality or tracking implementation.
