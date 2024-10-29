unit MaterialColor.Scheme.Neutral;

interface

uses
  MaterialColor.CAM.HCT,
  MaterialColor.DynamicColor.DynamicScheme;

type
  /// <summary>
  /// A theme that's slightly more chromatic than monochrome, which is purely black / white / gray.
  /// </summary>
  TSchemeNeutral = class(TDynamicSchemeBuilder)
  public
    /// <summary>
    /// Constructs a dynamic color scheme.
    /// </summary>
    /// <param name="set_source_color_hct">The source color in HCT color space.</param>
    /// <param name="set_is_dark">Indicates if the scheme is for dark mode.</param>
    /// <param name="set_contrast_level">The level of contrast adjustment. Default is 0.0.</param>
    /// <returns>A dynamically constructed color scheme.</returns>
    class function Construct(set_source_color_hct: THCT; set_is_dark: Boolean; set_contrast_level: Double = 0.0): TDynamicScheme; override;
  end;

implementation

uses
  MaterialColor.Utils,
  MaterialColor.DynamicColor.Variant,
  MaterialColor.Palettes.Tones;

{ TSchemeNeutral }

/// <summary>
/// Constructs a dynamic color scheme.
/// </summary>
/// <param name="set_source_color_hct">The source color in HCT color space.</param>
/// <param name="set_is_dark">Indicates if the scheme is for dark mode.</param>
/// <param name="set_contrast_level">The level of contrast adjustment. Default is 0.0.</param>
/// <returns>A dynamically constructed color scheme.</returns>
class function TSchemeNeutral.Construct(set_source_color_hct: THCT; set_is_dark: Boolean; set_contrast_level: Double): TDynamicScheme;
begin
  Result := TDynamicScheme.Create(
    (* source_color_argb: *) set_source_color_hct.ToInt(),
    (* variant: *) TDynamicColorVariant.kNeutral,
    (* contrast_level: *) set_contrast_level,
    (* is_dark: *) set_is_dark,
    (* primary_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue, 12.0),
    (* secondary_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue, 8.0),
    (* tertiary_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue, 16.0),
    (* neutral_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue, 2.0),
    (* neutral_variant_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue, 2.0)
  );
end;

end.

