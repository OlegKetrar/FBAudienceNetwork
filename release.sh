#! /bin/zsh

set -e

ci_branch="$(git branch --show-current)"

if [[ $ci_branch -ne "ci" ]]; then
  echo "$0 should only run on ci branch"
  exit 1
fi

updatePackageFile() {
  local url="$1"
  local sha="$2"
  local file="Package.swift"

  if [[ -z "$url" || -z "$sha" ]]; then
    echo "Usage: updatePackageFile <url> <checksum>"
    return 1
  fi

  if [[ ! -f "$file" ]]; then
    echo "Error: $file not found"
    return 1
  fi

  # Use sed to replace url and checksum
  sed -i '' -E \
    -e "s|url: \".*\"|url: \"$url\"|g" \
    -e "s|checksum: \".*\"|checksum: \"$sha\"|g" \
    "$file"

  echo "Updated Package.swift with:"
  echo "  url = $url"
  echo "  checksum = $sha"
}

git fetch && git pull

# update FBAudienceNetwork with cocoapods
# TODO: replace with `update --repo-update`

rbenv exec bundle install
rbenv exec bundle exec pod install

# parse fetched version
version=$(
  awk '
    $0=="PODS:" {in_pods=1; next}
    in_pods && $0 ~ /FBAudienceNetwork/ {
      gsub(/.*\(|\).*/, "", $0)
      print $0
      exit
    }
  ' Podfile.lock
)

# check if this version already released
# TODO:

current_dir="$(pwd)"
framework_path="binaries/FBAudienceNetwork.xcframework.zip"

rm -rf binaries
mkdir -p binaries

zip -r -X \
  "$framework_path" \
  "$current_dir/Pods/FBAudienceNetwork/Static/FBAudienceNetwork.xcframework"

framework_sha=$(swift package compute-checksum "$current_dir/$framework_path")
framework_url="https://github.com/OlegKetrar/FBAudienceNetwork/releases/download/$version/FBAudienceNetwork.xcframework.zip"

# push Podfile & Podfile.lock changes
# git add .
# git commit -m "bump pods"
# git push

# update Package.swift with newest version on master
git checkout master
git pull

updatePackageFile "$framework_url" "$framework_sha"

git add .
git commit -m "add $version version"
git push

# mak Github release
git tag "$version"
git push origin "$version"

gh release create "$version" "$framework_path" \
  --title "$version" \
  --notes "Binary release for SwiftPM"

echo "Release create successfully"