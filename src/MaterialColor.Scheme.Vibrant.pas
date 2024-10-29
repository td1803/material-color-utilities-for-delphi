unit MaterialColor.Scheme.Vibrant;

interface

uses
  MaterialColor.CAM.HCT,
  MaterialColor.DynamicColor.DynamicScheme;

type
  /// <summary>
  /// A loud theme, colorfulness is maximum for Primary palette, increased for others.
  /// </summary>
  TSchemeVibrant = class(TDynamicSchemeBuilder)
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
  MaterialColor.DynamicColor.Variant,
  MaterialColor.Palettes.Tones;

const
  kHues: TArray<Double> = [0, 41, 61, 101, 131, 181, 251, 301, 360];
  kSecondaryRotations: TArray<Double> = [18, 15, 10, 12, 15, 18, 15, 12, 12];
  kTertiaryRotations: TArray<Double> = [35, 30, 20, 25, 30, 35, 30, 25, 25];

{ TSchemeVibrant }

/// <summary>
/// Constructs a dynamic color scheme.
/// </summary>
/// <param name="set_source_color_hct">The source color in HCT color space.</param>
/// <param name="set_is_dark">Indicates if the scheme is for dark mode.</param>
/// <param name="set_contrast_level">The level of contrast adjustment. Default is 0.0.</param>
/// <returns>A dynamically constructed color scheme.</returns>
class function TSchemeVibrant.Construct(set_source_color_hct: THCT; set_is_dark: Boolean; set_contrast_level: Double): TDynamicScheme;
begin
  Result := TDynamicScheme.Create(
    (* source_color_argb: *) set_source_color_hct.ToInt(),
    (* variant: *) TDynamicColorVariant.kVibrant,
    (* contrast_level: *) set_contrast_level,
    (* is_dark: *) set_is_dark,
    (* primary_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue, 200.0),
    (* secondary_palette: *)
    TTonalPalette.Create(
      TDynamicScheme.GetRotatedHue(set_source_color_hct, kHues, kSecondaryRotations), 24.0),
    (* tertiary_palette: *)
    TTonalPalette.Create(
      TDynamicScheme.GetRotatedHue(set_source_color_hct, kHues, kTertiaryRotations), 32.0),
    (* neutral_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue, 10.0),
    (* neutral_variant_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue, 12.0)
  );
end;

end.

