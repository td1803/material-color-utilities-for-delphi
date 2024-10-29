unit MaterialColor.Scheme.Rainbow;

interface

uses
  MaterialColor.CAM.HCT,
  MaterialColor.DynamicColor.DynamicScheme;

type
  /// <summary>
  /// A playful theme - the source color's hue does not appear in the theme.
  /// </summary>
  TSchemeRainbow = class(TDynamicSchemeBuilder)
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

{ TSchemeRainbow }

/// <summary>
/// Constructs a dynamic color scheme.
/// </summary>
/// <param name="set_source_color_hct">The source color in HCT color space.</param>
/// <param name="set_is_dark">Indicates if the scheme is for dark mode.</param>
/// <param name="set_contrast_level">The level of contrast adjustment. Default is 0.0.</param>
/// <returns>A dynamically constructed color scheme.</returns>
class function TSchemeRainbow.Construct(set_source_color_hct: THCT; set_is_dark: Boolean; set_contrast_level: Double): TDynamicScheme;
begin
  Result := TDynamicScheme.Create(
    (* source_color_argb: *) set_source_color_hct.ToInt(),
    (* variant: *) TDynamicColorVariant.kRainbow,
    (* contrast_level: *) set_contrast_level,
    (* is_dark: *) set_is_dark,
    (* primary_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue, 48.0),
    (* secondary_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue, 16.0),
    (* tertiary_palette: *)
    TTonalPalette.Create(
        SanitizeDegreesDouble(set_source_color_hct.Hue + 60.0),
        24.0),
    (* neutral_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue, 0.0),
    (* neutral_variant_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue, 0.0)
  );
end;

end.

