//
//  WGS84TOGCJ02.m
//  GpsTest
//
//  Created by BlueBud on 14-6-13.
//
//

#import "WGS84TOGCJ02.h"

#define LAT_OFFSET_0(x,y) -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x))
#define LAT_OFFSET_1 (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0
#define LAT_OFFSET_2 (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0
#define LAT_OFFSET_3 (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0

#define LON_OFFSET_0(x,y) 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x))
#define LON_OFFSET_1 (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0
#define LON_OFFSET_2 (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0
#define LON_OFFSET_3 (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0

#define RANGE_LON_MAX 137.8347
#define RANGE_LON_MIN 72.004
#define RANGE_LAT_MAX 55.8271
#define RANGE_LAT_MIN 0.8293
// jzA = 6378245.0, 1/f = 298.3
// b = a * (1 - f)
// ee = (a^2 - b^2) / a^2;
#define jzA 6378245.0
#define jzEE 0.00669342162296594323

@implementation WGS84TOGCJ02

+ (double)transformLat:(double)x bdLon:(double)y
{
    double ret = LAT_OFFSET_0(x, y);
    ret += LAT_OFFSET_1;
    ret += LAT_OFFSET_2;
    ret += LAT_OFFSET_3;
    return ret;
}

+ (double)transformLon:(double)x bdLon:(double)y
{
    double ret = LON_OFFSET_0(x, y);
    ret += LON_OFFSET_1;
    ret += LON_OFFSET_2;
    ret += LON_OFFSET_3;
    return ret;
}

+ (BOOL)outOfChina:(double)lat bdLon:(double)lon
{
    if (lon < RANGE_LON_MIN || lon > RANGE_LON_MAX)
        return true;
    if (lat < RANGE_LAT_MIN || lat > RANGE_LAT_MAX)
        return true;
    if (![self detailInChina:CLLocationCoordinate2DMake(lat, lon)])
        return YES;

    return false;
}

+ (BOOL)detailInChina:(CLLocationCoordinate2D)tpt
{
    NSArray *chinaLines = @[@{@"lng":@"114.02626", @"lat":@"22.50686"},
                            @{@"lng":@"114.04995", @"lat":@"22.50274"},
                            @{@"lng":@"114.05639", @"lat":@"22.50464"},
                            @{@"lng":@"114.05879", @"lat":@"22.51336"},
                            @{@"lng":@"114.06489", @"lat":@"22.51677"},
                            @{@"lng":@"114.06978", @"lat":@"22.51764"},
                            @{@"lng":@"114.07295", @"lat":@"22.51907"},
                            @{@"lng":@"114.07956", @"lat":@"22.53120"},
                            @{@"lng":@"114.08695", @"lat":@"22.53334"},
                            @{@"lng":@"114.08935", @"lat":@"22.53699"},
                            @{@"lng":@"114.09381", @"lat":@"22.53651"},
                            @{@"lng":@"114.09690", @"lat":@"22.53405"},
                            @{@"lng":@"114.10420", @"lat":@"22.53524"},
                            @{@"lng":@"114.10849", @"lat":@"22.53287"},
                            @{@"lng":@"114.10978", @"lat":@"22.53049"},
                            @{@"lng":@"114.11175", @"lat":@"22.52961"},
                            @{@"lng":@"114.11467", @"lat":@"22.53065"},
                            @{@"lng":@"114.11604", @"lat":@"22.53199"},
                            @{@"lng":@"114.11638", @"lat":@"22.53398"},
                            @{@"lng":@"114.11999", @"lat":@"22.53508"},
                            @{@"lng":@"114.12299", @"lat":@"22.53849"},
                            @{@"lng":@"114.12565", @"lat":@"22.53992"},
                            @{@"lng":@"114.12866", @"lat":@"22.53992"},
                            @{@"lng":@"114.13029", @"lat":@"22.54190"},
                            @{@"lng":@"114.13407", @"lat":@"22.54170"},
                            @{@"lng":@"114.13733", @"lat":@"22.54357"},
                            @{@"lng":@"114.14046", @"lat":@"22.54289"},
                            @{@"lng":@"114.14149", @"lat":@"22.54277"},
                            @{@"lng":@"114.14209", @"lat":@"22.54202"},
                            @{@"lng":@"114.14287", @"lat":@"22.54219"},
                            @{@"lng":@"114.14419", @"lat":@"22.54212"},
                            @{@"lng":@"114.14441", @"lat":@"22.54124"},
                            @{@"lng":@"114.14615", @"lat":@"22.54135"},
                            @{@"lng":@"114.14856", @"lat":@"22.54203"},
                            @{@"lng":@"114.14837", @"lat":@"22.54372"},
                            @{@"lng":@"114.15052", @"lat":@"22.54641"},
                            @{@"lng":@"114.14958", @"lat":@"22.54754"},
                            @{@"lng":@"114.14969", @"lat":@"22.55032"},
                            @{@"lng":@"114.15076", @"lat":@"22.55099"},
                            @{@"lng":@"114.15166", @"lat":@"22.55166"},
                            @{@"lng":@"114.15196", @"lat":@"22.55460"},
                            @{@"lng":@"114.15557", @"lat":@"22.55481"},
                            @{@"lng":@"114.16093", @"lat":@"22.56096"},
                            @{@"lng":@"114.16222", @"lat":@"22.56076"},
                            @{@"lng":@"114.16329", @"lat":@"22.55929"},
                            @{@"lng":@"114.16561", @"lat":@"22.55945"},
                            @{@"lng":@"114.16672", @"lat":@"22.56068"},
                            @{@"lng":@"114.16750", @"lat":@"22.56119"},
                            @{@"lng":@"114.16904", @"lat":@"22.56108"},
                            @{@"lng":@"114.17046", @"lat":@"22.55985"},
                            @{@"lng":@"114.17501", @"lat":@"22.55913"},
                            @{@"lng":@"114.17741", @"lat":@"22.55755"},
                            @{@"lng":@"114.17797", @"lat":@"22.55565"},
                            @{@"lng":@"114.18089", @"lat":@"22.55513"},
                            @{@"lng":@"114.18346", @"lat":@"22.55543"},
                            @{@"lng":@"114.18674", @"lat":@"22.55477"},
                            @{@"lng":@"114.18784", @"lat":@"22.55561"},
                            @{@"lng":@"114.18962", @"lat":@"22.55456"},
                            @{@"lng":@"114.19325", @"lat":@"22.55541"},
                            @{@"lng":@"114.19578", @"lat":@"22.55586"},
                            @{@"lng":@"114.19672", @"lat":@"22.55705"},
                            @{@"lng":@"114.20101", @"lat":@"22.55729"},
                            @{@"lng":@"114.20239", @"lat":@"22.55634"},
                            @{@"lng":@"114.21054", @"lat":@"22.55674"},
                            @{@"lng":@"114.21458", @"lat":@"22.55452"},
                            @{@"lng":@"114.22033", @"lat":@"22.55253"},
                            @{@"lng":@"114.22445", @"lat":@"22.55047"},
                            @{@"lng":@"114.22606", @"lat":@"22.54708"},
                            @{@"lng":@"114.22584", @"lat":@"22.54522"},
                            @{@"lng":@"114.22693", @"lat":@"22.54326"},
                            @{@"lng":@"114.22889", @"lat":@"22.54235"},
                            @{@"lng":@"114.26004", @"lat":@"22.56143"},
                            @{@"lng":@"114.37986", @"lat":@"22.54812"},
                            @{@"lng":@"114.48080", @"lat":@"22.42027"},
                            @{@"lng":@"115.30890", @"lat":@"21.35306"},
                            @{@"lng":@"125.20758", @"lat":@"28.81794"},
                            @{@"lng":@"124.15289", @"lat":@"39.81042"},
                            @{@"lng":@"124.84503", @"lat":@"40.44045"},
                            @{@"lng":@"126.00958", @"lat":@"40.92366"},
                            @{@"lng":@"126.59185", @"lat":@"41.52686"},
                            @{@"lng":@"126.93243", @"lat":@"41.78952"},
                            @{@"lng":@"127.30597", @"lat":@"41.48572"},
                            @{@"lng":@"128.11895", @"lat":@"41.40337"},
                            @{@"lng":@"128.30572", @"lat":@"41.57619"},
                            @{@"lng":@"128.03106", @"lat":@"42.00214"},
                            @{@"lng":@"128.93194", @"lat":@"42.05111"},
                            @{@"lng":@"129.87677", @"lat":@"42.95821"},
                            @{@"lng":@"130.49200", @"lat":@"42.57107"},
                            @{@"lng":@"131.17315", @"lat":@"43.03856"},
                            @{@"lng":@"131.30499", @"lat":@"44.13667"},
                            @{@"lng":@"130.99737", @"lat":@"44.87318"},
                            @{@"lng":@"133.17266", @"lat":@"45.07525"},
                            @{@"lng":@"134.75470", @"lat":@"48.32867"},
                            @{@"lng":@"132.33770", @"lat":@"47.74097"},
                            @{@"lng":@"130.97540", @"lat":@"47.74097"},
                            @{@"lng":@"130.66778", @"lat":@"48.12374"},
                            @{@"lng":@"130.62384", @"lat":@"48.85187"},
                            @{@"lng":@"127.63556", @"lat":@"49.82539"},
                            @{@"lng":@"126.66876", @"lat":@"51.82371"},
                            @{@"lng":@"125.61407", @"lat":@"53.00304"},
                            @{@"lng":@"123.50470", @"lat":@"53.55482"},
                            @{@"lng":@"120.78009", @"lat":@"53.29295"},
                            @{@"lng":@"120.07696", @"lat":@"52.71116"},
                            @{@"lng":@"120.73614", @"lat":@"52.33683"},
                            @{@"lng":@"119.28595", @"lat":@"50.52895"},
                            @{@"lng":@"119.24200", @"lat":@"50.10806"},
                            @{@"lng":@"117.87970", @"lat":@"49.59806"},
                            @{@"lng":@"116.16583", @"lat":@"50.05166"},
                            @{@"lng":@"115.72638", @"lat":@"49.88205"},
                            @{@"lng":@"116.69317", @"lat":@"49.85373"},
                            @{@"lng":@"115.59454", @"lat":@"48.03566"},
                            @{@"lng":@"117.35235", @"lat":@"47.65224"},
                            @{@"lng":@"118.45098", @"lat":@"47.97685"},
                            @{@"lng":@"119.90118", @"lat":@"46.69635"},
                            @{@"lng":@"117.92364", @"lat":@"46.66620"},
                            @{@"lng":@"116.69317", @"lat":@"46.33345"},
                            @{@"lng":@"115.81427", @"lat":@"45.56962"},
                            @{@"lng":@"113.70489", @"lat":@"44.82644"},
                            @{@"lng":@"111.85919", @"lat":@"45.10627"},
                            @{@"lng":@"111.41973", @"lat":@"44.29415"},
                            @{@"lng":@"111.99102", @"lat":@"43.78873"},
                            @{@"lng":@"109.44220", @"lat":@"42.47390"},
                            @{@"lng":@"107.35479", @"lat":@"42.44148"},
                            @{@"lng":@"105.00372", @"lat":@"41.60906"},
                            @{@"lng":@"104.49835", @"lat":@"41.90410"},
                            @{@"lng":@"103.70733", @"lat":@"41.82228"},
                            @{@"lng":@"102.10333", @"lat":@"42.21406"},
                            @{@"lng":@"101.79571", @"lat":@"42.52250"},
                            @{@"lng":@"100.36749", @"lat":@"42.68423"},
                            @{@"lng":@"99.46661", @"lat":@"42.57107"},
                            @{@"lng":@"97.20343", @"lat":@"42.78107"},
                            @{@"lng":@"96.39044", @"lat":@"42.76494"},
                            @{@"lng":@"95.92901", @"lat":@"43.23098"},
                            @{@"lng":@"95.33575", @"lat":@"44.27842"},
                            @{@"lng":@"93.51202", @"lat":@"44.95098"},
                            @{@"lng":@"91.31475", @"lat":@"45.10627"},
                            @{@"lng":@"90.65557", @"lat":@"45.50806"},
                            @{@"lng":@"90.98516", @"lat":@"46.09017"},
                            @{@"lng":@"90.96319", @"lat":@"46.83181"},
                            @{@"lng":@"90.30401", @"lat":@"47.66704"},
                            @{@"lng":@"88.83184", @"lat":@"48.10907"},
                            @{@"lng":@"87.71124", @"lat":@"48.89522"},
                            @{@"lng":@"87.82110", @"lat":@"49.16894"},
                            @{@"lng":@"86.81036", @"lat":@"49.12582"},
                            @{@"lng":@"86.52472", @"lat":@"48.47454"},
                            @{@"lng":@"85.75567", @"lat":@"48.41624"},
                            @{@"lng":@"85.49200", @"lat":@"48.07971"},
                            @{@"lng":@"85.62384", @"lat":@"47.08675"},
                            @{@"lng":@"84.98663", @"lat":@"46.89190"},
                            @{@"lng":@"83.05304", @"lat":@"47.22123"},
                            @{@"lng":@"82.24005", @"lat":@"45.56962"},
                            @{@"lng":@"82.66851", @"lat":@"45.33842"},
                            @{@"lng":@"82.44879", @"lat":@"45.16827"},
                            @{@"lng":@"81.65777", @"lat":@"45.33842"},
                            @{@"lng":@"79.92193", @"lat":@"44.95098"},
                            @{@"lng":@"80.75689", @"lat":@"43.15088"},
                            @{@"lng":@"80.11969", @"lat":@"42.06742"},
                            @{@"lng":@"77.72467", @"lat":@"41.06463"},
                            @{@"lng":@"76.82379", @"lat":@"41.03149"},
                            @{@"lng":@"76.47223", @"lat":@"40.39863"},
                            @{@"lng":@"74.89019", @"lat":@"40.46553"},
                            @{@"lng":@"73.52789", @"lat":@"39.37017"},
                            @{@"lng":@"73.90142", @"lat":@"38.55008"},
                            @{@"lng":@"74.49469", @"lat":@"38.48131"},
                            @{@"lng":@"74.70343", @"lat":@"38.30048"},
                            @{@"lng":@"75.10992", @"lat":@"37.45064"},
                            @{@"lng":@"74.75836", @"lat":@"37.25851"},
                            @{@"lng":@"74.51666", @"lat":@"37.15351"},
                            @{@"lng":@"74.84625", @"lat":@"36.97818"},
                            @{@"lng":@"75.35162", @"lat":@"36.92550"},
                            @{@"lng":@"77.46099", @"lat":@"35.52528"},
                            @{@"lng":@"78.05426", @"lat":@"35.41791"},
                            @{@"lng":@"78.55963", @"lat":@"34.26378"},
                            @{@"lng":@"78.77935", @"lat":@"33.80857"},
                            @{@"lng":@"78.77935", @"lat":@"33.56175"},
                            @{@"lng":@"79.16388", @"lat":@"33.09359"},
                            @{@"lng":@"79.28473", @"lat":@"32.65069"},
                            @{@"lng":@"79.08697", @"lat":@"32.41913"},
                            @{@"lng":@"78.92218", @"lat":@"32.37275"},
                            @{@"lng":@"78.74640", @"lat":@"32.54888"},
                            @{@"lng":@"78.72442", @"lat":@"32.68768"},
                            @{@"lng":@"78.41681", @"lat":@"32.55814"},
                            @{@"lng":@"78.55963", @"lat":@"32.19628"},
                            @{@"lng":@"78.76287", @"lat":@"31.95890"},
                            @{@"lng":@"78.70794", @"lat":@"31.80030"},
                            @{@"lng":@"78.83429", @"lat":@"31.61805"},
                            @{@"lng":@"78.73541", @"lat":@"31.51040"},
                            @{@"lng":@"78.76837", @"lat":@"31.34165"},
                            @{@"lng":@"78.86175", @"lat":@"31.30411"},
                            @{@"lng":@"79.09796", @"lat":@"31.45418"},
                            @{@"lng":@"79.49347", @"lat":@"30.99384"},
                            @{@"lng":@"80.38336", @"lat":@"30.49339"},
                            @{@"lng":@"80.98761", @"lat":@"30.24695"},
                            @{@"lng":@"81.15240", @"lat":@"29.99988"},
                            @{@"lng":@"81.38311", @"lat":@"30.24695"},
                            @{@"lng":@"81.41607", @"lat":@"30.40816"},
                            @{@"lng":@"81.93243", @"lat":@"30.35129"},
                            @{@"lng":@"82.10821", @"lat":@"30.34181"},
                            @{@"lng":@"82.20709", @"lat":@"30.07597"},
                            @{@"lng":@"82.87725", @"lat":@"29.69495"},
                            @{@"lng":@"83.25079", @"lat":@"29.54214"},
                            @{@"lng":@"83.58038", @"lat":@"29.17828"},
                            @{@"lng":@"84.07476", @"lat":@"29.31249"},
                            @{@"lng":@"84.26153", @"lat":@"28.89011"},
                            @{@"lng":@"84.84381", @"lat":@"28.57220"},
                            @{@"lng":@"85.07452", @"lat":@"28.68792"},
                            @{@"lng":@"85.18438", @"lat":@"28.62043"},
                            @{@"lng":@"85.11847", @"lat":@"28.35005"},
                            @{@"lng":@"85.34918", @"lat":@"28.26300"},
                            @{@"lng":@"85.70074", @"lat":@"28.35972"},
                            @{@"lng":@"85.95343", @"lat":@"27.94320"},
                            @{@"lng":@"86.07428", @"lat":@"27.91408"},
                            @{@"lng":@"86.16217", @"lat":@"28.14682"},
                            @{@"lng":@"86.26104", @"lat":@"27.98201"},
                            @{@"lng":@"86.38189", @"lat":@"27.91408"},
                            @{@"lng":@"86.57965", @"lat":@"28.07899"},
                            @{@"lng":@"87.16192", @"lat":@"27.83638"},
                            @{@"lng":@"88.70001", @"lat":@"28.06929"},
                            @{@"lng":@"88.87579", @"lat":@"27.90437"},
                            @{@"lng":@"88.77691", @"lat":@"27.50557"},
                            @{@"lng":@"88.85382", @"lat":@"27.33979"},
                            @{@"lng":@"88.96368", @"lat":@"27.33979"},
                            @{@"lng":@"89.08453", @"lat":@"27.60297"},
                            @{@"lng":@"89.67779", @"lat":@"28.18556"},
                            @{@"lng":@"90.13922", @"lat":@"28.35972"},
                            @{@"lng":@"90.40289", @"lat":@"28.25332"},
                            @{@"lng":@"90.35894", @"lat":@"28.05960"},
                            @{@"lng":@"91.19390", @"lat":@"27.97231"},
                            @{@"lng":@"91.30377", @"lat":@"28.05960"},
                            @{@"lng":@"91.58941", @"lat":@"27.81695"},
                            @{@"lng":@"91.68829", @"lat":@"27.49583"},
                            @{@"lng":@"92.02887", @"lat":@"27.42759"},
                            @{@"lng":@"92.03985", @"lat":@"27.13466"},
                            @{@"lng":@"92.19366", @"lat":@"26.88016"},
                            @{@"lng":@"93.14947", @"lat":@"26.86056"},
                            @{@"lng":@"93.84161", @"lat":@"26.99769"},
                            @{@"lng":@"94.29205", @"lat":@"27.55428"},
                            @{@"lng":@"95.21490", @"lat":@"27.89466"},
                            @{@"lng":@"95.54449", @"lat":@"28.21461"},
                            @{@"lng":@"95.89605", @"lat":@"28.30170"},
                            @{@"lng":@"96.35748", @"lat":@"28.15650"},
                            @{@"lng":@"96.98370", @"lat":@"27.85581"},
                            @{@"lng":@"97.15948", @"lat":@"27.82667"},
                            @{@"lng":@"97.34625", @"lat":@"27.93349"},
                            @{@"lng":@"97.32428", @"lat":@"28.21461"},
                            @{@"lng":@"97.48907", @"lat":@"28.32104"},
                            @{@"lng":@"97.52203", @"lat":@"28.54325"},
                            @{@"lng":@"97.69781", @"lat":@"28.51429"},
                            @{@"lng":@"98.06036", @"lat":@"28.19524"},
                            @{@"lng":@"98.31305", @"lat":@"27.54454"},
                            @{@"lng":@"98.63165", @"lat":@"27.58350"},
                            @{@"lng":@"98.71954", @"lat":@"25.88614"},
                            @{@"lng":@"97.73077", @"lat":@"25.03308"},
                            @{@"lng":@"97.55499", @"lat":@"23.95335"},
                            @{@"lng":@"98.38995", @"lat":@"24.21413"},
                            @{@"lng":@"98.93927", @"lat":@"23.20826"},
                            @{@"lng":@"99.51056", @"lat":@"23.02638"},
                            @{@"lng":@"99.20294", @"lat":@"22.21510"},
                            @{@"lng":@"100.23565", @"lat":@"21.50135"},
                            @{@"lng":@"101.00470", @"lat":@"21.74647"},
                            @{@"lng":@"101.26837", @"lat":@"21.21486"},
                            @{@"lng":@"101.75177", @"lat":@"21.25582"},
                            @{@"lng":@"101.55401", @"lat":@"22.11336"},
                            @{@"lng":@"101.79571", @"lat":@"22.49959"},
                            @{@"lng":@"102.25714", @"lat":@"22.43868"},
                            @{@"lng":@"102.58673", @"lat":@"22.76324"},
                            @{@"lng":@"102.91632", @"lat":@"22.47929"},
                            @{@"lng":@"103.42169", @"lat":@"22.76324"},
                            @{@"lng":@"105.31134", @"lat":@"23.30919"},
                            @{@"lng":@"105.88263", @"lat":@"22.93536"},
                            @{@"lng":@"106.79449", @"lat":@"22.81389"},
                            @{@"lng":@"106.66265", @"lat":@"22.55033"},
                            @{@"lng":@"106.57476", @"lat":@"22.37774"},
                            @{@"lng":@"106.72857", @"lat":@"22.00135"},
                            @{@"lng":@"106.99224", @"lat":@"21.93003"},
                            @{@"lng":@"107.36578", @"lat":@"21.65460"},
                            @{@"lng":@"107.91510", @"lat":@"21.56267"},
                            @{@"lng":@"108.68414", @"lat":@"20.90729"},
                            @{@"lng":@"108.21173", @"lat":@"18.80984"},
                            @{@"lng":@"108.85992", @"lat":@"17.83993"},
                            @{@"lng":@"110.72760", @"lat":@"17.81902"},
                            @{@"lng":@"112.03497", @"lat":@"19.80519"},
                            @{@"lng":@"111.94708", @"lat":@"21.09191"},
                            @{@"lng":@"113.14459", @"lat":@"21.59332"},
                            @{@"lng":@"113.48722", @"lat":@"21.98925"},
                            @{@"lng":@"113.56585", @"lat":@"22.07677"},
                            @{@"lng":@"113.55383", @"lat":@"22.10477"},
                            @{@"lng":@"113.54799", @"lat":@"22.11431"},
                            @{@"lng":@"113.54937", @"lat":@"22.14484"},
                            @{@"lng":@"113.53838", @"lat":@"22.15756"},
                            @{@"lng":@"113.52739", @"lat":@"22.17918"},
                            @{@"lng":@"113.52739", @"lat":@"22.18776"},
                            @{@"lng":@"113.53598", @"lat":@"22.20398"},
                            @{@"lng":@"113.53396", @"lat":@"22.20894"},
                            @{@"lng":@"113.53289", @"lat":@"22.21224"},
                            @{@"lng":@"113.53486", @"lat":@"22.21347"},
                            @{@"lng":@"113.53769", @"lat":@"22.21363"},
                            @{@"lng":@"113.54061", @"lat":@"22.21296"},
                            @{@"lng":@"113.54160", @"lat":@"22.21371"},
                            @{@"lng":@"113.54263", @"lat":@"22.21605"},
                            @{@"lng":@"113.54349", @"lat":@"22.21685"},
                            @{@"lng":@"113.54542", @"lat":@"22.21705"},
                            @{@"lng":@"113.54748", @"lat":@"22.21677"},
                            @{@"lng":@"113.54919", @"lat":@"22.21673"},
                            @{@"lng":@"113.55469", @"lat":@"22.21800"},
                            @{@"lng":@"113.67871", @"lat":@"22.18848"},
                            @{@"lng":@"113.57434", @"lat":@"22.02180"},
                            @{@"lng":@"113.63065", @"lat":@"21.84856"},
                            @{@"lng":@"113.82016", @"lat":@"21.87659"},
                            @{@"lng":@"113.83664", @"lat":@"21.94667"},
                            @{@"lng":@"113.82016", @"lat":@"22.36131"},
                            @{@"lng":@"113.90256", @"lat":@"22.43241"},
                            @{@"lng":@"114.02626", @"lat":@"22.50686"}];
    //
    NSInteger meetPointNum = 0;
    
    for (NSInteger i=1; i<chinaLines.count; i++)
    {
        CLLocationCoordinate2D pt1 = CLLocationCoordinate2DMake([chinaLines[i-1][@"lat"] doubleValue], [chinaLines[i-1][@"lng"] doubleValue]);
        CLLocationCoordinate2D pt2 = CLLocationCoordinate2DMake([chinaLines[i][@"lat"] doubleValue], [chinaLines[i][@"lng"] doubleValue]);
        
        if( ( (tpt.longitude <= pt1.longitude && tpt.longitude >= pt2.longitude) || (tpt.longitude >= pt1.longitude && tpt.longitude <= pt2.longitude) ) && (tpt.latitude >= pt1.latitude || tpt.latitude >= pt2.latitude) )
        {
            if ([self judgePtInlinePoint1:pt1 point2:pt2 point:tpt])
            {
                return YES;
            }
            double temp = 0;
            //
            temp = pt1.longitude - pt2.longitude;
            if ( temp >= -0.0000000001 && temp <= 0.0000000001)
            {
                double dxx = tpt.longitude - pt1.longitude;
                
                if (dxx >= -0.0000000001 && dxx <= 0.0000000001)
                {
                    //
                    NSArray *indexs = [self getNotSame:chinaLines index:i];
                    
                    NSInteger index1 = [indexs[0] integerValue];
                    
                    NSInteger index2 = [indexs[1] integerValue];
                    
                    CLLocationCoordinate2D linePt1 = CLLocationCoordinate2DMake([chinaLines[index1][@"lat"] doubleValue], [chinaLines[index1][@"lng"] doubleValue]);
                    
                    CLLocationCoordinate2D linePt2 = CLLocationCoordinate2DMake([chinaLines[index2][@"lat"] doubleValue], [chinaLines[index2][@"lng"] doubleValue]);
                    
                    if (i>index1)
                    {
                        break;
                    }
                    else
                    {
                        i = index1+1;
                    }
                    if( tpt.latitude > pt1.latitude && ( (tpt.longitude >= linePt1.longitude && tpt.longitude <= linePt2.longitude) ||
                                                        (tpt.longitude >= linePt2.longitude && tpt.longitude <= linePt1.longitude)) )
                        meetPointNum++;
                }
            }
            else
            {
                double kk = 0;
                double bb = 0;
                double MeetPtY = 0;
                double MeetPtX = 0;
                kk = (pt1.latitude - pt2.latitude) / (pt1.longitude - pt2.longitude);
                bb = pt1.latitude - kk * pt1.longitude;
                MeetPtY = kk*tpt.longitude + bb;
                MeetPtX = tpt.longitude;
                //
                double dx = 0;
                double dy = 0;
                double dx2 = 0;
                double dy2 = 0;
                dx = MeetPtX - pt1.longitude;
                dy = MeetPtY - pt1.latitude;
                dx2 = MeetPtX - pt2.longitude;
                dy2 = MeetPtY - pt2.latitude;
                if( (dx >= -0.0000000001 && dx <= 0.0000000001 && dy >= -0.0000000001
                     && dy <= 0.0000000001) )
                {
                    CLLocationCoordinate2D pt3;
                    if (i == 1)
                    {
                        pt3 = CLLocationCoordinate2DMake([chinaLines[chinaLines.count - 2][@"lat"] doubleValue], [chinaLines[chinaLines.count - 2][@"lng"] doubleValue]);
                    }
                    else
                    {
                        pt3 = CLLocationCoordinate2DMake([chinaLines[i - 2][@"lat"] doubleValue], [chinaLines[i - 2][@"lng"] doubleValue]);
                    }
                    //
                    if( tpt.latitude > MeetPtY && ( (MeetPtX >= pt3.longitude && MeetPtX <= pt2.longitude) ||
                                                   (MeetPtX >= pt2.longitude && MeetPtX <= pt3.longitude)) )
                        meetPointNum++;
                }
                else if (!(dx2 >= -0.0000000001 && dx2 <= 0.0000000001 && dy2 >= -0.0000000001 && dy2 <= 0.0000000001))
                {
                    if (tpt.latitude > MeetPtY)
                        meetPointNum++;
                }
            }
        }
    }
    return (meetPointNum%2 == 1);
}

// 判断点是否在界线内
+ (BOOL)judgePtInlinePoint1:(CLLocationCoordinate2D)tpt1 point2:(CLLocationCoordinate2D)tpt2 point:(CLLocationCoordinate2D)tpt
{
    double dx1 = [self getDistancePoint1:tpt1 point2:tpt2];
    
    double dx2 = [self getDistancePoint1:tpt point2:tpt1];
    
    double dx3 = [self getDistancePoint1:tpt point2:tpt2];
    
    double dx = dx3+dx2-dx1;
    
    if (dx >= -0.0000000001 && dx <= 0.0000000001 )
    {
        return YES;
    }
    return NO;
}

// 获取两点之间的距离
+ (double)getDistancePoint1:(CLLocationCoordinate2D) tpt1 point2:(CLLocationCoordinate2D) tpt2
{
    double x = tpt1.longitude - tpt2.longitude;
    if (x <= 0)
    {
        x = -x;
    }
    double y = tpt1.latitude - tpt2.latitude;
    if (y <= 0)
    {
        y = -y;
    }
    return sqrt(x*x+y*y);
}

+ (NSArray *)getNotSame:(NSArray *)points index:(NSInteger)index
{
    NSMutableArray *indexs = [[NSMutableArray alloc] initWithCapacity:0];
    
    [indexs addObject:@(-1)];
    
    [indexs addObject:@(-1)];
    
//    NSArray *indexs = @[@(-1),@(-1)];

    NSInteger size = points.count;
    
    CLLocationCoordinate2D buftpt;
    
    CLLocationCoordinate2D tpt = CLLocationCoordinate2DMake([points[index][@"lat"] doubleValue], [points[index][@"lng"] doubleValue]);
    
    for (NSInteger i = index; i < size; i++)
    {
        buftpt = CLLocationCoordinate2DMake([points[i][@"lat"] doubleValue], [points[i][@"lng"] doubleValue]);
        
        if (buftpt.longitude != tpt.longitude)
        {
            indexs[0] = @(i);
            
            break;
        }
    }
    if ([indexs[0] integerValue] == -1)
    {
        for (int j = 0; j < size; j++)
        {
            buftpt = CLLocationCoordinate2DMake([points[j][@"lat"] doubleValue], [points[j][@"lng"] doubleValue]);
            if (buftpt.longitude != tpt.longitude)
            {
                indexs[0] = @(j);
                break;
            }
        }
    }
    for (NSInteger k = index; k >= 0; k--)
    {
        buftpt = CLLocationCoordinate2DMake([points[k][@"lat"] doubleValue], [points[k][@"lng"] doubleValue]);
        if (buftpt.longitude != tpt.longitude)
        {
            indexs[1] = @(k);
            break;
        }
    }
    if ([indexs[1] integerValue] == -1)
    {
        for (NSInteger l = size-1; l >= 0; l--)
        {
            buftpt = CLLocationCoordinate2DMake([points[l][@"lat"] doubleValue], [points[l][@"lng"] doubleValue]);
            if (buftpt.longitude != tpt.longitude)
            {
                indexs[1] = @(l);
                break;
            }
        }
    }
    
    if ([indexs[0] integerValue] == -1 || [indexs[1] integerValue] == -1)
    {
        
    }
    return indexs;
}

+ (CLLocationCoordinate2D)gcj02Encrypt:(double)ggLat bdLon:(double)ggLon
{
    CLLocationCoordinate2D resPoint;
    double mgLat;
    double mgLon;
    if ([self outOfChina:ggLat bdLon:ggLon]) {
        resPoint.latitude = ggLat;
        resPoint.longitude = ggLon;
        return resPoint;
    }
    double dLat = [self transformLat:(ggLon - 105.0)bdLon:(ggLat - 35.0)];
    double dLon = [self transformLon:(ggLon - 105.0) bdLon:(ggLat - 35.0)];
    double radLat = ggLat / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - jzEE * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((jzA * (1 - jzEE)) / (magic * sqrtMagic) * M_PI);
    dLon = (dLon * 180.0) / (jzA / sqrtMagic * cos(radLat) * M_PI);
    mgLat = ggLat + dLat;
    mgLon = ggLon + dLon;
    
    resPoint.latitude = mgLat;
    resPoint.longitude = mgLon;
    return resPoint;
}

+ (CLLocationCoordinate2D)gcj02Decrypt:(double)gjLat gjLon:(double)gjLon {
    CLLocationCoordinate2D  gPt = [self gcj02Encrypt:gjLat bdLon:gjLon];
    double dLon = gPt.longitude - gjLon;
    double dLat = gPt.latitude - gjLat;
    CLLocationCoordinate2D pt;
    pt.latitude = gjLat - dLat;
    pt.longitude = gjLon - dLon;
    return pt;
}

+ (CLLocationCoordinate2D)bd09Decrypt:(double)bdLat bdLon:(double)bdLon
{
    CLLocationCoordinate2D gcjPt;
    double x = bdLon - 0.0065, y = bdLat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * M_PI);
    double theta = atan2(y, x) - 0.000003 * cos(x * M_PI);
    gcjPt.longitude = z * cos(theta);
    gcjPt.latitude = z * sin(theta);
    return gcjPt;
}

+(CLLocationCoordinate2D)bd09Encrypt:(double)ggLat bdLon:(double)ggLon
{
    CLLocationCoordinate2D bdPt;
    double x = ggLon, y = ggLat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * M_PI);
    double theta = atan2(y, x) + 0.000003 * cos(x * M_PI);
    bdPt.longitude = z * cos(theta) + 0.0065;
    bdPt.latitude = z * sin(theta) + 0.006;
    return bdPt;
}

+ (CLLocationCoordinate2D)wgs84ToGcj02:(CLLocationCoordinate2D)location
{
    return [self gcj02Encrypt:location.latitude bdLon:location.longitude];
}

+ (CLLocationCoordinate2D)gcj02ToWgs84:(CLLocationCoordinate2D)location
{
    return [self gcj02Decrypt:location.latitude gjLon:location.longitude];
}


+ (CLLocationCoordinate2D)wgs84ToBd09:(CLLocationCoordinate2D)location
{
    CLLocationCoordinate2D gcj02Pt = [self gcj02Encrypt:location.latitude
                                                  bdLon:location.longitude];
    return [self bd09Encrypt:gcj02Pt.latitude bdLon:gcj02Pt.longitude] ;
}

+ (CLLocationCoordinate2D)gcj02ToBd09:(CLLocationCoordinate2D)location
{
    return  [self bd09Encrypt:location.latitude bdLon:location.longitude];
}

+ (CLLocationCoordinate2D)bd09ToGcj02:(CLLocationCoordinate2D)location
{
    return [self bd09Decrypt:location.latitude bdLon:location.longitude];
}

+ (CLLocationCoordinate2D)bd09ToWgs84:(CLLocationCoordinate2D)location
{
    CLLocationCoordinate2D gcj02 = [self bd09ToGcj02:location];
    return [self gcj02Decrypt:gcj02.latitude gjLon:gcj02.longitude];
}
@end
